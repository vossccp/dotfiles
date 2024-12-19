return {
  dir = "~/.config/nvim/lua/xtest",
  dev = true,
  config = function()
    vim.cmd("command! XTest :lua require('xtest').run_test()")
    vim.cmd("command! XTestClass :lua require('xtest').run_all_tests_in_class()")
    vim.cmd("command! XTestAll :lua require('xtest').run_all_tests()")
  end,
}
