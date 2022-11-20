local status, mason = pcall(require, "mason")
if (not status) then return end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup()

lspconfig.setup {
  ensure_installed = { "sumneko_lua", "tsserver", "bashls", "cssls", "dockerls", "eslint", "gopls", "graphql", "html",
    "kotlin_language_server", "ltex", "marksman" },
  automatic_installation = true
}
