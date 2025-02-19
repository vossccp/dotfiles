return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({})
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup({
  --       contrast = "hard",
  --       italics = false,
  --     })
  --     vim.o.background = "dark"
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
  --
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard" -- Options: 'soft', 'medium', 'hard'
      vim.g.gruvbox_material_enable_italic = 1
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
}
