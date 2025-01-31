return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },

  config = function()
    local mason = require("mason")
    local neodev = require("neodev")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    -- These are the language servers we want to configure ourselves
    -- rest should be done by mason-lspconfig
    local install_manually = {
      "ts_ls",
      "denols",
      "lua_ls",
    }

    local ensure_installed = {
      "ts_ls",
      "denols",
      "html",
      "svelte",
      "lua_ls",
    }

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })

    neodev.setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities))

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

    lspconfig.denols.setup({
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    lspconfig.ts_ls.setup({
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    })

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

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client == nil then
          return
        end

        if client.name == "omnisharp" then
          local omnisharpExtended = require("omnisharp_extended")

          -- This can also jump to decomplied code...
          map("gd", omnisharpExtended.lsp_definition, "[G]oto [D]efinition")
          map("gr", omnisharpExtended.telescope_lsp_references, "[G]oto [R]eferences")
        else
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        end

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("§", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>§", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>lr", vim.lsp.buf.rename, "[L]anguage [R]ename")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<C-l>", vim.lsp.buf.code_action, "[C]ode Action")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gl", vim.lsp.buf.declaration, "[G]oto Dec[l]aration")

        map("K", vim.lsp.buf.hover, "Show Hover")
      end,
    })
  end,
}
