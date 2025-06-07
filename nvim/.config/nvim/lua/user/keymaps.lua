local function map(mode, lhs, rhs, desc)
  local options = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move current line down
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- Move current line up

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- dont yank using x
map("n", "x", '"_x')
map("n", "X", '"_X')

map("v", "<", "<gv", "Better indenting")
map("v", ">", ">gv", "Better indenting")

map("n", "<leader>sa", "ggVG", "[S]elect [a]ll")

map("n", "<leader>dd", '"_d', "Delete without yanking")
map("n", "<leader>y", '"*y', "Yank to system clipboard")
map("v", "<leader>y", '"*y', "Yank to system clipboard")
map("n", "<leader>h", "<cmd>nohlsearch<CR>", "Toggle highlighting")

map("n", "<Tab>", ":bnext<CR>", "Next Buffer")
map("n", "<S-Tab>", ":bprev<CR>", "Previous Buffer")
map("n", "<C-h>", ":bdel<CR>", "Close Buffer")

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

map("n", "<C-q>", ":call QuickFixToggle()<CR>", "Quickfix")

map("n", "]q", ":cnext<CR>", "Next Quickfix")
map("n", "[q", ":cprev<CR>", "Previous Quickfix")

map("n", "]b", ":bnext<CR>", "Next Buffer")
map("n", "[b", ":bprev<CR>", "Previous Buffer")

local diag = vim.diagnostic
vim.keymap.set('n', '[e', function()
  diag.goto_prev({ severity = diag.severity.ERROR })
end, { desc = 'Go to previous error' })
vim.keymap.set('n', ']e', function()
  diag.goto_next({ severity = diag.severity.ERROR })
end, { desc = 'Go to next error' })

map("n", "[[", ":BufferLinePick<CR>", "Previous Buffer")

-- sometimes I hit those keys accidentally on my small keyboard
map("n", "<Home>", "<Nop>", "No Home")
map("n", "<End>", "<Nop>", "No End")
map("n", "<PageUp>", "<Nop>", "No Page Up")
map("n", "<PageDown>", "<Nop>", "No Home")

map("i", "<End>", "<Nop>", "No End")
map("i", "<Home>", "<Nop>", "No Page Up")
map("i", "<PageUp>", "<Nop>", "No Page Down")
map("i", "<PageDown>", "<Nop>", "No Page Down")

map("v", "<End>", "<Nop>", "No End")
map("v", "<Home>", "<Nop>", "No Page Up")
map("v", "<PageUp>", "<Nop>", "No Page Down")
map("v", "<PageDown>", "<Nop>", "No Page Down")
map("v", "<PageDown>", "<Nop>", "No Page Down")

map("n", "<Space><Space>", "<C-^>", "Switch between buffers")
map("n", "<Space>w", "<CMD>bdelete<CR>", "Close buffer")
map("n", "-", "<CMD>Oil<CR>", "Open parent directory")
map("n", "<Space>v", "<cmd>Telescope neoclip<CR>", "Paste from clipboard")
map("t", "<ESC>", "<C-\\><C-n>", "exit terminal mode")
