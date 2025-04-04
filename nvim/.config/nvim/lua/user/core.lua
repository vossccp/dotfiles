vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.termguicolors = true
vim.opt.relativenumber = true

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.backup = false
vim.opt.showcmd = true

vim.opt.laststatus = 2
vim.opt.expandtab = true

vim.opt.scrolloff = 10

vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- No Wrap lines
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }

-- Finding files - Search down into subfolders
vim.opt.path:append("**")
vim.opt.wildignore:append("*/node_modules/*")

-- this adds a column to the left side to
-- give space for any signs
vim.wo.signcolumn = "yes"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append("r")

vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Disable status messages in extra line!
vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.splitright = true
vim.o.completeopt = "menuone,noselect"
vim.o.spelllang = "de_de"
vim.o.conceallevel = 2
