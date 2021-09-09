lua require("theprimeagen")

lua require("refactoring").setup({})

vnoremap <silent> <leader>rr :lua require("theprimeagen.telescope").refactors()<CR>
nnoremap <silent> <leader>rr :lua require("theprimeagen.telescope").refactors()<CR>
nnoremap <silent> <leader>df :lua require("refactoring").debug.printf({below = false})<CR>
nnoremap <silent> <leader>db :lua require("refactoring").debug.printf({below = true})<CR>

