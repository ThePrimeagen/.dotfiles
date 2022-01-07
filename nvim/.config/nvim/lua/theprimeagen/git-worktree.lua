local Worktree = require("git-worktree")

Worktree.on_tree_change(function(_ --[[op]], path, _ --[[upstream]])
    M.execute(path.path)
end)

return M
