return {
  "github/copilot.vim",
  enabled = false,
  config = function()
    vim.keymap.set("i", "<C-f>", "<Plug>(copilot-accept-word)")
  end,
}
