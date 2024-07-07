return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set('i', '<C-f>', '<Plug>(copilot-accept-word)')
  end,
}
