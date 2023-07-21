local mason = require("mason")
local lspconfig = require("mason-lspconfig")

mason.setup()

lspconfig.setup {
  ensure_installed = { "lua_ls", "html", "kotlin_language_server", "marksman", "jsonls" },
  automatic_installation = {
    -- dont automatically install typescript server
    -- it will be installed via plugin Typescript and
    -- manully configured in lsp config
    exclude = { "tsserver" }
  }
}
