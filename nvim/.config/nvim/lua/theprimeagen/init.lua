function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
		bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end

Nnoremap = CreateNoremap("n", { noremap = true })
Inoremap = CreateNoremap("i", { noremap = true })

require("theprimeagen.telescope")
require("theprimeagen.git-worktree")
require("theprimeagen.debugger")
require("theprimeagen.harpoon")
require("theprimeagen.lsp")
require("theprimeagen.nvim-treesitter-context")

require("refactoring.config").setup({
	formatting = {
		typescript = {},
		javascript = {},
	},
})

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end
