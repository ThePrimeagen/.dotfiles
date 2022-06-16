local M = {}

function M.nnoremap(lhs, rhs) 
	vim.keymap.set("n", lhs, rhs, {noremap = true })
end

local nnoremap = M.nnoremap

return M
