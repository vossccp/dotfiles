return {
  'taybart/b64.nvim',
  config = function()
    local b64 = require('b64')
    -- vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('v', '<leader>eb', b64.encode, { desc = 'Base64: Encode' })
    vim.keymap.set('v', '<leader>ed', b64.decode, { desc = 'Base64: Decode' })
  end,
}
