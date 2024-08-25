return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require('oil')
    oil.setup({
      skip_confirm_for_simple_edits = true,
      -- prompt_save_on_select_new_entry = false
    })
  end
}
