nnoremap <left> :lua require("jvim").to_parent()<CR>
nnoremap <right> :lua require("jvim").descend()<CR>
nnoremap <up> :lua require("jvim").prev_sibling()<CR>
nnoremap <down> :lua require("jvim").next_sibling()<CR>

