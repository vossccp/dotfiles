return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { "kkharji/sqlite.lua", module = "sqlite" },
  },
  config = function()
    require("neoclip").setup({
      keys = {
        telescope = {
          i = {
            paste = "<cr>",
          },
          n = {
            paste = "<cr>",
          },
        },
      },
    })
  end,
}
