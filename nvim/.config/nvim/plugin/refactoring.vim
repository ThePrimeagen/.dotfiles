lua require("theprimeagen")

nnoremap <leader>rr :lua require('theprimeagen.telescope').refactors()<CR>
nnoremap <leader>dg :lua require('refactoring').debug.printf({below = false})<CR>
nnoremap <leader>dm :lua require('refactoring').debug.printf({below = true})<CR>

