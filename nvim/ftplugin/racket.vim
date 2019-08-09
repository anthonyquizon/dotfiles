
nnoremap <silent> -r :call VimuxRunCommand(",rr " . fnamemodify(expand("%"), ":~:."))<cr>
nnoremap <silent> -R :call VimuxRunCommand("(require \"" . fnamemodify(expand("%"), ":~:.") . "\")")<cr>
nnoremap <silent> -e :call VimuxRunCommand(",en " . fnamemodify(expand("%"), ":~:."))<cr>
nnoremap <silent> -t :call VimuxRunCommand("(require (submod \"" . fnamemodify(expand("%"), ":~:.") . "\" test))")<cr>
vnoremap <silent> -r "vy :call VimuxRunCommand(@v)<CR>

noremap -<leader> :call VimuxSendText(getline('.') . "\n,bt\n")<CR>
noremap _<leader> :call VimuxSendText(getline('.')) . "\n,bt\n"<CR>

