
nnoremap <silent> <leader>r :call VimuxRunCommand(",rr " . bufname("%"))<cr>
nnoremap <silent> <leader>e :call VimuxRunCommand(",en " . bufname("%"))<cr>
nnoremap <silent> <leader>x :call VimuxRunCommand("(require (submod \"" . bufname("%") . "\" test))")<cr>
