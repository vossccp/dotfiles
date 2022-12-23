local toggleterm = require("toggleterm")

toggleterm.setup {
  open_mapping = [[<c-\>]],
}

vim.keymap.set('n', '<C-\\>', '<Cmd>ToggleTerm direction="float"<CR>', {})
