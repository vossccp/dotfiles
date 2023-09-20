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

		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
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
		end

		-- used to enable autocompletion (assign to every lsp server config)
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

		-- lspconfig["tsserver"].setup({
		-- 	server = {
		-- 		capabilities = capabilities,
		-- 		on_attach = on_attach,
		-- 	},
		-- })

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
