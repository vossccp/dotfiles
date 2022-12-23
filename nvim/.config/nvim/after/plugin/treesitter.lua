local ts = require("nvim-treesitter.configs")

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "c_sharp",
    "graphql",
    "go",
    "dockerfile",
    "gitignore",
    "markdown",
    "latex",
    "toml",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "vim"
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
