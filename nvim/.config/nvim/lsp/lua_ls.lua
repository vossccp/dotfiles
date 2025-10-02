local capabilities = require("blink.cmp").get_lsp_capabilities()

return {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
        disable = { "missing-fields" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
        },
      },
    },
  },
}
