return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "pmizio/typescript-tools.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
    {
      "j-hui/fidget.nvim",
      opts = {}
    },
  },

  config = function()
    local lsp_commons = require("user.lsp_commons")
    local mason = require("mason")
    local neodev = require("neodev")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    -- These are the language servers we want to configure ourselves
    -- rest should be done by mason-lspconfig
    local install_manually = {
      "tsserver",
      "omnisharp",
      "lua_ls",
    }

    local ensure_installed = {
      "tsserver",
      "html",
      "omnisharp",
      "svelte",
      "lua_ls",
      "graphql",
    }

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })

    neodev.setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local typescript_tools = require("typescript-tools")
    typescript_tools.setup({
      capabilities = capabilities,
      on_attach = lsp_commons.on_attach,
    })

    local pid = vim.fn.getpid()
    local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
    lspconfig["omnisharp"].setup({
      cmd = {
        mason_path .. "/bin/omnisharp",
        "--languageserver",
        "--hostPID",
        tostring(pid),
      },
      handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
      },
      on_attach = lsp_commons.on_attach,
      capabilities = capabilities,
      settings = {
        omnisharp = {
          loggingLevel = "debug",
          useModernNet = true,
        },
      },
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = lsp_commons.on_attach,
      settings = {
        Lua = {
          diagnostics = {
            -- make the language server recognize "vim" global
            globals = { "vim" },
            disable = { "missing-fields" },
          },

          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        -- dont setup the language server if it is already setup
        if vim.tbl_contains(install_manually, server_name) then
          return
        end

        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = lsp_commons.on_attach,
        })
      end,
    })
  end,
}
