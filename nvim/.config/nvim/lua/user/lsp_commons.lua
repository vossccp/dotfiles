local M = {}

M.on_attach = function(client, bufnr)
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
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Show hover" })
	buf_set_keymap(
		"n",
		"<C-l>",
		"<Cmd>lua vim.lsp.buf.code_action()<CR>",
		{ noremap = true, silent = true, desc = "Code actions" }
	)
	buf_set_keymap(
		"i",
		"<C-l>",
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

	if client.name == "typescript-tools" then
		buf_set_keymap(
			"n",
			"<leader>lo",
			"<cmd>TSToolsOrganizeImports<cr>",
			{ noremap = true, silent = true, desc = "Organize Imports" }
		)

		buf_set_keymap(
			"n",
			"<leader>lO",
			"<cmd>TSToolsSortImports<cr>",
			{ noremap = true, silent = true, desc = "Sort Imports" }
		)

		buf_set_keymap(
			"n",
			"<leader>lz",
			"<cmd>TSToolsGoToSourceDefinition<cr>",
			{ noremap = true, silent = true, desc = "Go To Source Definition" }
		)

		buf_set_keymap("n", "<leader>lf", "<cmd>TSToolsFixAll<cr>", { noremap = true, silent = true, desc = "Fix all" })
	end
end

return M
