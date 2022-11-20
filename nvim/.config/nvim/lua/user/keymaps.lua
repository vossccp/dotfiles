local function map(mode, lhs, rhs, desc)
  local options = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- dont yank using x
map('n', 'x', '"_x')
map('n', 'X', '"_X')

map('n', '<C-h>', '<C-w>h', "Window left")
map('n', '<C-j>', '<C-w>j', "Window right")
map('n', '<C-k>', '<C-w>k', "Window bottom")
map('n', '<C-l>', '<C-w>l', "Window top")

-- Window resizing
map('n', '<A-Left>', '<C-w><', "Resize window left")
map('n', '<A-Right>', '<C-w>>', "Resize window right")
map('n', '<A-Up>', '<C-w>+', "Resice window up")
map('n', '<A-Down>', '<C-w>-', "Resize window down")

map("n", "<leader>d", '"_d', "Delete without yanking")
map("n", "<leader>y", '"*y', "Yank to system clipboard")
map("v", "<leader>y", '"*y', "Yank to system clipboard")
map("n", "<leader>h", '<cmd>nohlsearch<CR>', "Toggle highlighting")

map("n", "<leader>c", '<cmd>bdelete<CR>', "Close Buffer")
map("n", "<leader>C", '<cmd>bdelete!<CR>', "Close Buffer!")

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

map('n', '<C-q>', ':call QuickFixToggle()<CR>', "Quickfix")
map('n', ']q', ':cnext<CR>', "Next Quickfix")
map('n', '[q', ':cprev<CR>', "Previous Quickfix")

map("n", "gE", "<cmd>lua vim.diagnostic.goto_prev { severity = 'Error' }<cr>", "Previous Error")
map("n", "ge", "<cmd>lua vim.diagnostic.goto_next { severity = 'Error' }<cr>", "Next Error")

-- Cycle through Buffers
map('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', "Next Buffer")
map('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', "Previous Buffer")
