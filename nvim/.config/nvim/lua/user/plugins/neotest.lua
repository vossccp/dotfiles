return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/nvim-nio",
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

    vim.keymap.set("n", "<leader>tt", "<cmd>Neotest run<CR>", { desc = "Run test" })
    vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run last<CR>", { desc = "Run last test" })
    vim.keymap.set("n", "<leader>ta", "<cmd>Neotest run file<CR>", { desc = "Run all tests in file" })
    vim.keymap.set("n", "<leader>to", "<cmd>Neotest output-panel<CR>", { desc = "Open test output-panel" })
    vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary<CR>", { desc = "Open test summary" })
    vim.keymap.set("n", "<leader>tn", "<cmd>Neotest jump next<CR>", { desc = "Jump to next test" })
    vim.keymap.set("n", "<leader>tp", "<cmd>Neotest jump prev<CR>", { desc = "Jump to previous test" })

    vim.keymap.set("n", "<leader>dt", function()
      neotest.run.run({ strategy = "dap" })
    end, { desc = "Debug test" })
  end,
}
