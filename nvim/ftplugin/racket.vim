
nnoremap <silent> -r :call VimuxRunCommand(",rr " . bufname("%"))<cr>
nnoremap <silent> -R :call VimuxRunCommand("(require \"" . bufname("%") . "\")")<cr>
nnoremap <silent> -e :call VimuxRunCommand(",en " . bufname("%"))<cr>
nnoremap <silent> -t :call VimuxRunCommand("(require (submod \"" . bufname("%") . "\" test))")<cr>
vnoremap <silent> -r "vy :call VimuxRunCommand(@v)<CR>

