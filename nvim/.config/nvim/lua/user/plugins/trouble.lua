return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle<CR>",                       desc = "Open/close trouble list" },
    { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Open trouble document diagnostics" },
    { "<leader>tq", "<cmd>TroubleToggle quickfix<CR>",              desc = "Open trouble quickfix list" },
    { "<leader>tl", "<cmd>TroubleToggle loclist<CR>",               desc = "Open trouble location list" },
  },
}
