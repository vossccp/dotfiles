lvim.log.level = "warn"
vim.opt.relativenumber = true
vim.opt.cmdheight = 1

lvim.leader = "space"
lvim.format_on_save.enabled = true
lvim.colorscheme = "darkplus"
lvim.transparent_window = false

lvim.builtin.project.active = true

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

require("user.plugins")
require("user.keymap")
