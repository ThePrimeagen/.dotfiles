require("theprimeagen.set")
require("theprimeagen.packer")
require("theprimeagen.neogit")
require("theprimeagen.debugger")
require("theprimeagen.rtp")

local augroup = vim.api.nvim_create_augroup
ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

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

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = ThePrimeagenGroup,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

--[[
vim.cmd('sign define bar linehl=ColorColumn')

local function barify()
    -- vim.fn.clearmatches()
    vim.cmd('sign unplace *')
    local cur_line = vim.fn.line('.')
    local jump = 5
    local offs = jump * 3
    for line = cur_line - offs, cur_line + offs, jump do
        if line ~= cur_line and line > 0 then
            -- vim.fn.matchaddpos('ColorColumn', {line})
            vim.cmd(string.format(
            'sign place %d name=bar line=%d',
            line, line))
        end
    end
end

vim.api.nvim_create_autocmd(
{ "CursorMoved", "CursorMovedI" }, { callback = barify })
--]]
