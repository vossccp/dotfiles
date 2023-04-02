local function map(mode, lhs, rhs, desc)
  local options = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- dont yank using x
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map("v", "<", "<gv", "Better indenting")
map("v", ">", ">gv", "Better indenting")

map('n', '\\a', 'ggVG', 'Select all')

map("n", "<leader>d", '"_d', "Delete without yanking")
map("n", "<leader>y", '"*y', "Yank to system clipboard")
map("v", "<leader>y", '"*y', "Yank to system clipboard")
map("n", "<leader>h", '<cmd>nohlsearch<CR>', "Toggle highlighting")

map("n", "<C-w>", '<cmd>bdelete<CR>', "Close Buffer")
map("n", "<C-W>", '<cmd>bdelete!<CR>', "Close Buffer!")

-- map("n", "<leader>c", '<cmd>bdelete<CR>', "Close Buffer")
-- map("n", "<leader>C", '<cmd>bdelete!<CR>', "Close Buffer!")

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

map('n', '[w', '<Plug>CamelCaseMotion_w', "CamelCaseMotion w")
map('n', '[b', '<Plug>CamelCaseMotion_b', "CamelCaseMotion b")
map('n', '[e', '<Plug>CamelCaseMotion_e', "CamelCaseMotion e")

map('v', '[w', '<Plug>CamelCaseMotion_iw', "CamelCaseMotion iw")
map('v', '[b', '<Plug>CamelCaseMotion_ib', "CamelCaseMotion ib")

map("n", "gE", "<cmd>lua vim.diagnostic.goto_prev { severity = 'Error' }<cr>", "Previous Error")
map("n", "ge", "<cmd>lua vim.diagnostic.goto_next { severity = 'Error' }<cr>", "Next Error")

-- Cycle through Buffers
map('n', '<C-k>', '<Cmd>BufferLineCycleNext<CR>', "Next Buffer")
map('n', '<C-j>', '<Cmd>BufferLineCyclePrev<CR>', "Previous Buffer")

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
