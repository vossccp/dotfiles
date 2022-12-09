local luasnip = require("luasnip")

require('luasnip.loaders.from_vscode').lazy_load()

luasnip.snippets = {
  all = {
    luasnip.parser.parse_snippet("expand", "---expanded by me")
  }
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })
