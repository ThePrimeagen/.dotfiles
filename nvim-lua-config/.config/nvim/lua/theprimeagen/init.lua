require("theprimeagen.set")
require("theprimeagen.packer")
require("theprimeagen.neogit")

local autocmd = vim.api.nvim_create_autocmd 
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('HighlightYank', {}) 

autocmd('TextYankPost', { 
    group = yank_group, 
    pattern = '*', 
    callback = function() 
        vim.highlight.on_yank({ 
            higroup = 'IncSearch', 
            timeout = 40,
        }) 
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


