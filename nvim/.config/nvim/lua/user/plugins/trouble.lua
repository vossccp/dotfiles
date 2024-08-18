return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  cmd = { "Trouble" },
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>",    desc = "Open/close trouble list" },
    { "<leader>tw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>td", "<cmd>Trouble document_diagnostics<CR>",  desc = "Open trouble document diagnostics" },
    { "<leader>tq", "<cmd>Trouble quickfix<CR>",              desc = "Open trouble quickfix list" },
    { "<leader>tl", "<cmd>Trouble loclist<CR>",               desc = "Open trouble location list" },
  },
}
