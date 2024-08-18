return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_dropdown({}),
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = true,
          previewer = false,
          file_ignore_patterns = { "node_modules" }
        },
        git_files = {
          theme = "dropdown",
          previewer = false,
        },
        lsp_document_symbols = {
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local keymap = vim.keymap

    local builtin = require("telescope.builtin")

    keymap.set("n", "<C-p>", builtin.find_files, {})
    keymap.set("n", "<C-f>", builtin.live_grep, {})
    keymap.set("n", "<Space><Space>", builtin.buffers, {})
    keymap.set("n", "§", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" })
    keymap.set(
      "n",
      "<leader>gfc",
      "<cmd>Telescope git_bcommits<cr>",
      { desc = "Show git commits for current buffer" }
    )
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" })
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" })
  end,
}
