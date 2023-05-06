local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  if client.name == "omnisharp" then
    client.server_capabilities.semanticTokensProvider = {
      full = vim.empty_dict(),
      legend = {
        tokenModifiers = { "static_symbol" },
        tokenTypes = {
          "comment",
          "excluded_code",
          "identifier",
          "keyword",
          "keyword_control",
          "number",
          "operator",
          "operator_overloaded",
          "preprocessor_keyword",
          "string",
          "whitespace",
          "text",
          "static_symbol",
          "preprocessor_text",
          "punctuation",
          "string_verbatim",
          "string_escape_character",
          "class_name",
          "delegate_name",
          "enum_name",
          "interface_name",
          "module_name",
          "struct_name",
          "type_parameter_name",
          "field_name",
          "enum_member_name",
          "constant_name",
          "local_name",
          "parameter_name",
          "method_name",
          "extension_method_name",
          "property_name",
          "event_name",
          "namespace_name",
          "label_name",
          "xml_doc_comment_attribute_name",
          "xml_doc_comment_attribute_quotes",
          "xml_doc_comment_attribute_value",
          "xml_doc_comment_cdata_section",
          "xml_doc_comment_comment",
          "xml_doc_comment_delimiter",
          "xml_doc_comment_entity_reference",
          "xml_doc_comment_name",
          "xml_doc_comment_processing_instruction",
          "xml_doc_comment_text",
          "xml_literal_attribute_name",
          "xml_literal_attribute_quotes",
          "xml_literal_attribute_value",
          "xml_literal_cdata_section",
          "xml_literal_comment",
          "xml_literal_delimiter",
          "xml_literal_embedded_expression",
          "xml_literal_entity_reference",
          "xml_literal_name",
          "xml_literal_processing_instruction",
          "xml_literal_text",
          "regex_comment",
          "regex_character_class",
          "regex_anchor",
          "regex_quantifier",
          "regex_grouping",
          "regex_alternation",
          "regex_text",
          "regex_self_escaped_character",
          "regex_other_escape",
        },
      },
      range = true,
    }
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap(
    "n",
    "gD",
    "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    { noremap = true, silent = true, desc = "Goto Declaration" }
  )
  buf_set_keymap(
    "n",
    "gd",
    "<Cmd>lua vim.lsp.buf.definition()<CR>",
    { noremap = true, silent = true, desc = "Goto Definition" }
  )
  buf_set_keymap(
    "n",
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    { noremap = true, silent = true, desc = "Goto Implementation" }
  )
  buf_set_keymap(
    "n",
    "gr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    { noremap = true, silent = true, desc = "Goto Implementation" }
  )
  buf_set_keymap(
    "n",
    "K",
    "<Cmd>lua vim.lsp.buf.hover()<CR>",
    { noremap = true, silent = true, desc = "Show hover" }
  )
  buf_set_keymap(
    "n",
    "<C-a>",
    "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    { noremap = true, silent = true, desc = "Code actions" }
  )
  buf_set_keymap(
    "i",
    "<C-a>",
    "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    { noremap = true, silent = true, desc = "Code actions" }
  )
  buf_set_keymap(
    "n",
    "<leader>lr",
    "<Cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true, desc = "Rename" }
  )
  buf_set_keymap(
    "n",
    "<leader>lf",
    "<Cmd>lua vim.lsp.buf.format()<CR>",
    { noremap = true, silent = true, desc = "Format" }
  )
  buf_set_keymap(
    "n",
    "<leader>lc",
    "<Cmd>lua vim.lsp.codelens.run()<CR>",
    { noremap = true, silent = true, desc = "Codelens" }
  )

  enable_format_on_save(client, bufnr)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
  { border = require 'misc.style'.border })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
  { border = require 'misc.style'.border })

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local typescript_status, typescript = pcall(require, "typescript")
if (typescript_status) then
  -- extended typescript integration
  -- adds extra commands like Organize Imports
  typescript.setup {
    -- prevent the plugin from creating Vim commands
    disable_commands = false,
    -- enable debug logging for commands
    debug = false,
    go_to_source_definition = {
      -- fall back to standard LSP definition on failure
      fallback = true,
    },
    -- pass options to lspconfig's setup method
    server = {
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        on_attach(client, bufnr)

        buf_set_keymap(
          'n',
          '<leader>li',
          '<Cmd>TypescriptAddMissingImports<CR>',
          { noremap = true, silent = true, desc = "Add missing imports" }
        )

        buf_set_keymap(
          'n',
          '<leader>lo',
          '<Cmd>TypescriptOrganizeImports<CR>',
          { noremap = true, silent = true, desc = "Organise imports" }
        )

        buf_set_keymap(
          'n',
          '<leader>lu',
          '<Cmd>TypescriptRemoveUnused<CR>',
          { noremap = true, silent = true, desc = "Removed unused" }
        )

        buf_set_keymap(
          'n',
          '<leader>lg',
          '<Cmd>TypescriptGoToSourceDefinition<CR>',
          { noremap = true, silent = true, desc = "Goto source definition" }
        )
      end,
      filetypes = { "javascript", "javascriptreact", "javascript.tsx", "typescript", "typescriptreact", "typescript.tsx" },
      cmd = { "typescript-language-server", "--stdio" },
      capabilities = capabilities,
    },
  }
end

local servers = { 'bashls', "dockerls", "kotlin_language_server", "gopls", "graphql", "marksman" }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require 'lspconfig'.ltex.setup {
  filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex" },
}

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
nvim_lsp.omnisharp.setup({
  cmd = {
    mason_path .. "/bin/omnisharp",
  },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    omnisharp = {
      loggingLevel = "debug",
      useModernNet = true,
    },
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
