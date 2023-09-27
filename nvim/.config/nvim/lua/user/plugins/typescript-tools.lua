return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		local lspCommons = require("user.lsp_commons")
		require("typescript-tools").setup({
			on_attach = lspCommons.on_attach,
		})
	end,
}
