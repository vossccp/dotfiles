local ls = require("luasnip")

require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets" } })
require('luasnip.loaders.from_vscode').lazy_load()

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  ext_opts = {
    [".md"] = {
      active = true,
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200)
  ext_base_prio = 300,
  -- minimal increase in priority
  ext_prio_increase = 1,
  enable_autosnippets = true,
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
