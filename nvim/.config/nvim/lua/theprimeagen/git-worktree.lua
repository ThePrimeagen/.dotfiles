local Worktree = require("git-worktree")

local function is_nrdp(path)
    local found = path:find(vim.env["NRDP"])
    return type(found) == "number" and found > 0
end

local function is_tvui(path)
    local found = path:find(vim.env["TVUI"])
    return type(found) == "number" and found > 0
end

local M = {}
function M.execute(path, just_build)
    if is_nrdp(path) then
        local command = string.format(":silent !tmux-nrdp tmux %s %s", path, just_build)
        vim.cmd(command)
    elseif is_tvui(path) then
        print("EXECUTE ", path)
        local command = string.format(":!tmux-tvui %s", path)
        vim.cmd(command)
    end
end

Worktree.on_tree_change(function(_ --[[op]], path, _ --[[upstream]])
    M.execute(path.path)
end)

return M
