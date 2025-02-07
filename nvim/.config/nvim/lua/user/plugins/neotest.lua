return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      log_level = 1,
      adapters = {
        require("neotest-dotnet")({
          discovery_root = "project",
        }),
      },
    })

    vim.keymap.set("n", "<leader>tr", "<cmd>Neotest run<CR>", { desc = "Run test" })
    vim.keymap.set("n", "<leader>ta", "<cmd>Neotest run file<CR>", { desc = "Run all tests in file" })
    vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<CR>", { desc = "Open test output" })
  end,
}
