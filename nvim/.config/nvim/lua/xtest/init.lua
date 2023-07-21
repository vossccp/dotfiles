local last_test_cmd = nil

local ts_utils = require("nvim-treesitter.ts_utils")

local function get_child(node, child_name)
  local child = node:child(0)
  while child ~= nil and child:type() ~= child_name do
    child = child:next_sibling()
  end
  if child then
    return child
  end
  return nil
end

local function get_text(node, bufnr)
  return vim.treesitter.get_node_text(node, bufnr)
end

local function is_xunit_test(node, bufnr)
  local attributes = get_child(node, "attribute_list")
  if attributes then
    local child = attributes:child(0)
    while child ~= nil do
      if child:type() == "attribute" then
        local identifier = get_child(child, "identifier")
        if identifier then
          local attribute_name = get_text(identifier, bufnr)
          if attribute_name == "Fact" or attribute_name == "Theory" then
            return true
          end
        end
      end
      child = child:next_sibling()
    end
  end
  return false
end


local function get_test()
  local bufnr = vim.api.nvim_get_current_buf()
  local language_tree = vim.treesitter.get_parser(bufnr, "c_sharp")
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  local q_namespace = vim.treesitter.query.parse(
    "c_sharp",
    [[
      (file_scoped_namespace_declaration
       name: (qualified_name) @namespace)
    ]]
  )

  local ns
  for _, captures in q_namespace:iter_matches(root, bufnr) do
    ns = vim.treesitter.get_node_text(captures[1], bufnr)
  end

  local current_node = ts_utils.get_node_at_cursor()
  while current_node ~= nil and current_node:type() ~= "method_declaration" do
    current_node = current_node:parent()
  end

  local method_name = nil
  if current_node then
    if is_xunit_test(current_node, bufnr) then
      local name = current_node:field("name")[1]
      if name ~= nil then
        method_name = get_text(name, bufnr)
      end
    end
  end

  while current_node ~= nil and current_node:type() ~= "class_declaration" do
    current_node = current_node:parent()
  end

  local class_name = nil
  if current_node then
    local identifier = get_child(current_node, "identifier")
    class_name = get_text(identifier, bufnr)
  end

  return {
    namespace = ns,
    class_name = class_name,
    method_name = method_name
  }
end

local function run_test()
  local tests = get_test()
  if tests.method_name ~= nil then
    last_test_cmd = "terminal dotnet test --logger \"console;verbosity=detailed\" --filter " ..
        tests.namespace .. "." .. tests.class_name .. "." .. tests.method_name
    vim.cmd(
      "vsplit | " .. last_test_cmd)
  else
    if (last_test_cmd) then
      vim.cmd(last_test_cmd)
    else
      vim.cmd("echo 'Not a XUnit test'")
    end
  end
end

local function run_all_tests_in_class()
  local tests = get_test()
  if tests.class_name ~= nil then
    last_test_cmd = "terminal dotnet test --logger \"console;verbosity=detailed\" --filter " ..
        tests.namespace .. "." .. tests.class_name
    vim.cmd(
      "vsplit | " .. last_test_cmd)
  else
    if (last_test_cmd) then
      vim.cmd(last_test_cmd)
    else
      vim.cmd("echo 'Not a XUnit test class'")
    end
  end
end

local function run_all_tests()
  local command = "terminal dotnet test --logger \"console;verbosity=detailed\" --filter Category!=ManualTest"
  vim.cmd(
    "vsplit | " .. command)
end

return {
  get_test = get_test,
  run_test = run_test,
  run_all_tests_in_class = run_all_tests_in_class,
  run_all_tests = run_all_tests
}
