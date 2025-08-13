return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    local oil = require("oil")
    oil.setup({
      skip_confirm_for_simple_edits = true,

      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
    })
  end,
}
