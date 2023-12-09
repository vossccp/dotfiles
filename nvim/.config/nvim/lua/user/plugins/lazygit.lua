return {
	"kdheepak/lazygit.nvim",
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local wk = require("which-key")

		wk.register({
			g = {
				name = "Git",
				g = { "<cmd>LazyGit<cr>", "LazyGit" },
			},
		}, { prefix = "<leader>" })
	end,
}
