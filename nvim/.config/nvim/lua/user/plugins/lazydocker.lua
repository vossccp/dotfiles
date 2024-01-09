return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("lazydocker").setup()
    vim.keymap.set('n', '<leader>gd', ":LazyDocker<CR>", {})
  end

}
