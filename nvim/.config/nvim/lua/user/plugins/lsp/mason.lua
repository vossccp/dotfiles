return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"omnisharp",
				"svelte",
				"lua_ls",
				"graphql",
			},
			automatic_installation = true,
		})

		mason_null_ls.setup({
			ensure_installed = {
				"prettier",
				"csharpier",
				"stylua",
			},
			automatic_installation = true,
		})
	end,
}
