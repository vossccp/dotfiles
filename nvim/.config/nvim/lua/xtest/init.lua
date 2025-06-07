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
  for _, match, _ in q_namespace:iter_matches(root, bufnr, 0, -1) do
    local node_list = match[1] -- this is an array of TSNode
    if node_list and node_list[1] then
      ns = vim.treesitter.get_node_text(node_list[1], bufnr)
      break
    end
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
    method_name = method_name,
  }
end

local function open_popup_and_run(cmd)
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate popup size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Optional: Make sure 'winblend' is set if you want a nice transparency effect
  -- vim.api.nvim_win_set_option(win, "winblend", 10)

  -- You might want to switch to terminal mode once it's opened
  vim.api.nvim_command("startinsert")

  -- Capture output if needed
  local stdout_lines = {}

  -- Configure the terminal job
  vim.fn.termopen(cmd, {
    on_stdout = function(_, data, _)
      -- Data is a table of lines.
      -- Accumulate output if you want to process it later.
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(stdout_lines, line)
        end
      end
    end,
    on_exit = function()
      -- Once the command finishes, you can stop inserting mode
      -- and let the user press <Enter> to close
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)

      -- You can display a message or simply leave the output as is.
      -- Now map <CR> in terminal-mode to close the window
      -- Note: Since we exited terminal-mode, map in normal mode or re-enter terminal mode as needed
      vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", ":close<CR>", { noremap = true, silent = true })

      -- If you wanted to process stdout_lines, you could do it here.
      -- For example, print them in a message:
      -- vim.notify("Command completed:\n" .. table.concat(stdout_lines, "\n"))
    end,
  })
end

local function run_test()
  local tests = get_test()
  if tests.method_name ~= nil then
    last_test_cmd = 'dotnet test --logger "console;verbosity=detailed" --filter '
      .. tests.namespace
      .. "."
      .. tests.class_name
      .. "."
      .. tests.method_name

    open_popup_and_run(last_test_cmd)
  else
    if last_test_cmd then
      vim.cmd(last_test_cmd)
    else
      vim.cmd("echo 'Not a XUnit test'")
    end
  end
end

local function run_all_tests_in_class()
  local tests = get_test()
  if tests.class_name ~= nil then
    last_test_cmd = 'dotnet test --logger "console" --filter ' .. tests.namespace .. "." .. tests.class_name
    open_popup_and_run(last_test_cmd)
  else
    if last_test_cmd then
      vim.cmd(last_test_cmd)
    else
      vim.cmd("echo 'Not a XUnit test class'")
    end
  end
end

local function run_all_tests()
  local command = 'dotnet test --logger "console" --filter Category!=ManualTest'
  open_popup_and_run(command)
end

return {
  get_test = get_test,
  run_test = run_test,
  run_all_tests_in_class = run_all_tests_in_class,
  run_all_tests = run_all_tests,
}
