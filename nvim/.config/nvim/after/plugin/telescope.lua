local telescope = require("telescope")

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true,
      previewer = false
    },
    git_files = {
      theme = "dropdown",
      previewer = false
    },
    lsp_document_symbols = {
      theme = "dropdown",
      previewer = false
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
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
}

local whichkey = require("which-key")

whichkey.register({
  s = {
    name = "Search",
    t = {
      function()
        builtin.live_grep()
      end,
      "Text"
    },
    d = {
      function()
        builtin.diagnostics()
      end,
      "Diagnostics"
    },
    h = {
      function()
        builtin.help_tags()
      end,
      "Help tags",
    },
  },
  g = {
    function()
      builtin.git_files({
        no_ignore = false,
        hidden = true
      })
    end,
    "Git Files",
  },
  b = {
    function()
      builtin.buffers()
    end,
    "Buffers",
  },
}, { prefix = "<leader>" })

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})

whichkey.register({
  ["§"] = {
    function()
      builtin.lsp_document_symbols()
    end,
    "Document symbols",
  }
})
