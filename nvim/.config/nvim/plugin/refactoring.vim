lua require("theprimeagen")
lua require("refactoring").setup({})

vnoremap <silent> <leader>rr :lua require("theprimeagen.telescope").refactors()<CR>
vnoremap <silent> <leader>re :lua require("refactoring").refactor(106)<CR>

nnoremap <silent> <leader>ri :lua require("refactoring").refactor(123)<CR>

nnoremap <silent> <leader>dh :lua print(vim.inspect(require("refactoring").debug.get_path()))<CR>
nnoremap <silent> <leader>dg :lua require("refactoring").debug.printf({below = false})<CR>
nnoremap <silent> <leader>dm :lua require("refactoring").debug.printf({below = true})<CR>
nnoremap <silent> <leader>df :lua require("refactoring").debug.print_var({below = false})<CR>
nnoremap <silent> <leader>db :lua require("refactoring").debug.print_var({below = true})<CR>

