local status, telescope = pcall(require, "telescope")
if (not status) then return end

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
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

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
    g = {
      function()
        builtin.help_tags()
      end,
      "Tags"
    },
    d = {
      function()
        builtin.diagnostics()
      end,
      "Diagnostics"
    },
  },
  f = {
    function()
      builtin.find_files({
        no_ignore = false,
        hidden = true
      })
    end,
    "Find Git Files",
  },
  b = {
    function()
      builtin.buffers()
    end,
    "Buffers",
  },
  e = {
    function()
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 }
      })
    end,
    "File Browser",
  },
}, { prefix = "<leader>" })

whichkey.register({
  ["§"] = {
    function()
      builtin.buffers()
    end,
    "Document symbols",
  }
})
