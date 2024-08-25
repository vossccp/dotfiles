return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "pmizio/typescript-tools.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
  },

  config = function()
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
      "yamlls",
    }

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })

    neodev.setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local typescript_tools = require("typescript-tools")
    typescript_tools.setup({
      capabilities = capabilities
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
      capabilities = capabilities,
      enable_import_completion = true,
      organize_imports_on_format = true,
      enable_roslyn_analyzers = true,
      settings = {
        omnisharp = {
          loggingLevel = "debug",
          useModernNet = true,
        },
      },
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
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

    lspconfig.yamlls.setup {
      settings = {
        yaml = {
          format = {
            enable = true
          },
          schemaStore = {
            enable = false
          },
          schemas = {
            kubernetes = "*.yaml",
          },
        },
      },
    }

    mason_lspconfig.setup_handlers({
      function(server_name)
        -- dont setup the language server if it is already setup
        if vim.tbl_contains(install_manually, server_name) then
          return
        end

        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.name == "omnisharp" then
          -- This can also jump to decomplied code...
          map('gd', "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>", '[G]oto [D]efinition')
          map('gr', "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>", '[G]oto [R]eferences')
        else
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        end

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('§', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>§', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>lr', vim.lsp.buf.rename, '[L]anguage [R]ename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<C-l>', vim.lsp.buf.code_action, '[C]ode Action')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('K', vim.lsp.buf.hover, 'Show Hover')

        if client and client.name == "typescript-tools" then
          map('<leader>lo', "<cmd>TSToolsOrganizeImports<cr>", '[L]anguage [O]rganize Imports')
          map('<leader>lO', "<cmd>TSToolsSortImports<cr>", '[L]anguage S[O]rt Imports')
          map('<leader>lz', "<cmd>TSToolsGoToSourceDefinition<cr>", '[L]anguage Goto [Z]ource Definition')
          map('<leader>fa', "<cmd>TSToolsFixAll<cr>", '[L]anguage [F]ix [A]ll')
        end
      end,
    })
  end,
}
