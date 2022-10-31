local Remap = require("theprimeagen.keymap")
local nnoremap = Remap.nnoremap

local builtin = require("telescope.builtin")
local default_conf = require("theprimeagen.telescope")
local telescope = require("telescope")

nnoremap("<C-p>", ":Telescope")
nnoremap("<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<C-p>", function()
    builtin.git_files()
end)
nnoremap("<Leader>pf", function()
    builtin.find_files()
end)

nnoremap("<leader>pw", function()
    builtin.grep_string { search = vim.fn.expand("<cword>") }
end)
nnoremap("<leader>pb", function()
    builtin.buffers()
end)
nnoremap("<leader>vh", function()
    builtin.help_tags()
end)

-- TODO: Fix this immediately
nnoremap("<leader>vwh", function()
    builtin.help_tags()
end)

nnoremap("<leader>vrc", function()
    default_conf.search_dotfiles({ hidden = true })
end)
nnoremap("<leader>va", function()
    default_conf.anime_selector()
end)
nnoremap("<leader>vc", function()
    default_conf.chat_selector()
end)
nnoremap("<leader>gc", function()
    default_conf.git_branches()
end)
nnoremap("<leader>gw", function()
    telescope.extensions.git_worktree.git_worktrees()
end)
nnoremap("<leader>gm", function()
    telescope.extensions.git_worktree.create_git_worktree()
end)
nnoremap("<leader>td", function()
    default_conf.dev()
end)



