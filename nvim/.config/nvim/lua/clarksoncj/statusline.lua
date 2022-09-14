--[[
PrimeWriteCount = PrimeWriteCount or 0

local function get_file_name()
    local name = vim.fn.bufname(0)

    if not name or name == "" then
        return "(no name)"
    end

    return name
end

local function lsp_info()

    local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
    local errors = vim.lsp.diagnostic.get_count(0, "Error")
    local hints = vim.lsp.diagnostic.get_count(0, "Hint")

    return string.format("LSP: H %d W %d E %d", hints, warnings, errors)
end

local function harpoon_status()
    local status = require("harpoon.mark").status()
    if status == "" then
        status = "N"
    end

    return string.format("H:%s", status)
end

function StatusLine()
    local statusline = ""
    return string.format(statusline,
        PrimeWriteCount,
        constrain_string(get_file_name(), 23, false),
        get_git_info(),
        lsp_info(),
        "H:O", -- harpoon_status(),
        status_line)
end

vim.o.statusline = '%!v:lua.StatusLine()'

local M = {}

M.on_write = function()
    PrimeWriteCount = PrimeWriteCount + 1
end

M.set_write = function(count)
    PrimeWriteCount = count
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local status_group = augroup('PrimeStatusLine', {})

autocmd('PrimeStatusLineCmd', {
    group = status_group,
    pattern = '*',
    callback = function()
        M.on_write()
    end,
})

return M



--]]
