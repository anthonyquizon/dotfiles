
nnoremap <silent> <leader>r :call VimuxRunCommand(",rr " . bufname("%"))<cr>
nnoremap <silent> <leader>R :call VimuxRunCommand("(require \"" . bufname("%") . "\")")<cr>
nnoremap <silent> <leader>e :call VimuxRunCommand(",en " . bufname("%"))<cr>
nnoremap <silent> <leader>t :call VimuxRunCommand("(require (submod \"" . bufname("%") . "\" test))")<cr>
vnoremap <silent> <leader>r "vy :call VimuxRunCommand(@v)<CR>

