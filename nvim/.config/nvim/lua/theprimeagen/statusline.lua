local Worktree = require("git-worktree")
local path = require("plenary.path").path

local write_count = 0
local git_branch = ""
local status_line = ""

local last_name = nil
local last_name_results = nil

local function constrain_string(line, max_len, cut_on_end)
    if #line <= max_len then
        return line
    end

    if cut_on_end then
        return line:sub(max_len - 3) .. "..."
    end
    return "..." .. line:sub(max_len - 3)
end

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function get_file_name()
    local name = vim.fn.bufname(0)

    if not name or name == "" then
        return "(no name)"
    end

    return name
end

local function get_git_info(force)

    if force or not git_branch or git_branch == "" then
        git_branch = vim.fn["fugitive#head"]()
        if not git_branch or git_branch == "" then
            git_branch = '(no git)'
        end
        git_branch = constrain_string(git_branch, 14)
    end

    return git_branch
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

Worktree.on_tree_change(function(op)
    if op == Worktree.Operations.Switch then
        get_git_info(true)
    end
end)

local statusline = "%%-4.4(%d%%)%%-15.23(%s%%)|%%-14.14(%s%%)%%-20.20(%s%%)%%-6.6(%s%%)%%-30.70(%s%%)"
function StatusLine()
    return string.format(statusline,
        write_count,
        constrain_string(get_file_name(), 23, false),
        get_git_info(),
        lsp_info(),
        "H:O", -- harpoon_status(),
        status_line)
end

vim.o.statusline = '%!v:lua.StatusLine()'

local M = {}

M.on_write = function()
    write_count = write_count + 1
end

M.set_write = function(count)
    write_count = count
end

M.set_status = function(line)
    status_line = line
end

vim.api.nvim_exec([[
augroup THEPRIMEAGEN_STATUSLINE
    autocmd!
    autocmd BufWritePre * :lua require("theprimeagen.statusline").on_write()
augroup END
 ]], false)

return M
