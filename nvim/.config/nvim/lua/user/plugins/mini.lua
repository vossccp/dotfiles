return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
    require("mini.tabline").setup()
    require("mini.comment").setup()
    require("mini.pairs").setup()
  end,
}
