local telescope = require("telescope")

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

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
  f = {
    function()
      builtin.find_files({
        no_ignore = false,
        hidden = true
      })
    end,
    "Find Files",
  },
  b = {
    function()
      builtin.buffers()
    end,
    "Buffers",
  },
}, { prefix = "<leader>" })

vim.keymap.set('n', '<C-p>', builtin.find_files, {})

whichkey.register({
  ["§"] = {
    function()
      builtin.lsp_document_symbols()
    end,
    "Document symbols",
  }
})
