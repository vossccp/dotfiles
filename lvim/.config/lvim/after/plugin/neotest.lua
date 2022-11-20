local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

vim.api.nvim_create_user_command('Neotest', function()
  neotest.run.run()
end, {
  desc = 'Neotest: run nearest test'
})

vim.api.nvim_create_user_command('NeotestDebug', function()
  neotest.run.run({ strategy = "dap" })
end, {
  desc = 'Neotest: debug nearest test'
})

vim.api.nvim_create_user_command('NeotestFile', function()
  neotest.run.run(vim.fn.expand '%')
end, {
  desc = 'Neotest: run test in current file'
})

vim.api.nvim_create_user_command('NeotestStop', function()
  neotest.run.stop()
end, {
  desc = 'Neotest: stop test execution'
})

vim.api.nvim_create_user_command('NeotestAttach', function()
  neotest.run.attach()
end, {
  desc = 'Neotest: attach to currently running test'
})

vim.api.nvim_create_user_command('NeotestSummaryOpen', function()
  neotest.summary.open()
end, {
  desc = 'Neotest: open summary window'
})

vim.api.nvim_create_user_command('NeotestSummaryClose', function()
  neotest.summary.open()
end, {
  desc = 'Neotest: close summary window'
})

neotest.setup {
  adapters = {
    require("neotest-dotnet"),
    require("neotest-jest")({
      jestCommand = "yarn test",
    })
  },
}
