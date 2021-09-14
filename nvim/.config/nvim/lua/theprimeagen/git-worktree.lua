local Worktree = require("git-worktree")

Worktree.on_tree_change(function(op, path, upstream)
    if op == Worktree.Operations.Switch then
    elseif op == Worktree.Operations.Create then
    end
end)

