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

map("v", "<", "<gv", "Better indenting")
map("v", ">", ">gv", "Better indenting")

-- Move Lines, doesnt work
-- map('n', '<A-j>', ':m .+1<CR>==', 'Move lines')
-- map("v", "<A-j>", ":m '>+1<CR>gv=v")
-- map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- map("n", "<A-k>", ":m .-2<CR>==")
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- map("n", "<C-A>", "gg<S-v>G", "Select all")

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

-- sometimes I hit those keys accidentally on my small keyboard
map('n', '<Home>', '<Nop>', "No Home")
map('n', '<End>', '<Nop>', "No End")
map('n', '<PageUp>', '<Nop>', "No Page Up")
map('n', '<PageDown>', '<Nop>', "No Home")

map('i', '<End>', '<Nop>', "No End")
map('i', '<Home>', '<Nop>', "No Page Up")
map('i', '<PageUp>', '<Nop>', "No Page Down")
map('i', '<PageDown>', '<Nop>', "No Page Down")

map('v', '<End>', '<Nop>', "No End")
map('v', '<Home>', '<Nop>', "No Page Up")
map('v', '<PageUp>', '<Nop>', "No Page Down")
map('v', '<PageDown>', '<Nop>', "No Page Down")
