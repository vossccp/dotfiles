vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "aerospace.toml",
  command = "!aerospace reload-config"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "pandoc" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})
