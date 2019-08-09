

nnoremap <silent> -r :call VimuxRunCommand(":r")<cr>
nnoremap <silent> -R :call VimuxRunCommand(":r")<cr>
nnoremap <silent> -e :call VimuxRunCommand(":l " . fnamemodify(expand("%"), ":~:."))<cr>
vnoremap <silent> -r "vy :call VimuxRunCommand(@v)<CR>

noremap -<leader> :call VimuxSendText(getline('.') . "\n,bt\n")<CR>
noremap _<leader> :call VimuxSendText(getline('.')) . "\n,bt\n"<CR>
