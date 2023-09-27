return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"jose-elias-alvarez/typescript.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"smjonas/inc-rename.nvim",
			config = true,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local typescript = require("typescript-tools")
		local lspCommons = require("user.lsp_commons")

		local on_attach = lspCommons.on_attach
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		typescript.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
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
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				omnisharp = {
					loggingLevel = "debug",
					useModernNet = true,
				},
			},
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["graphql"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
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
	end,
}
