local capabilities = require("blink.cmp").get_lsp_capabilities()

return {
  cmd = { "tinymist", "lsp" },
  settings = {
    exportPdf = "never",
    formatterMode = "typstyle",
  },
  capabilities = capabilities,
}
