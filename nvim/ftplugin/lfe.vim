
nnoremap <silent> <leader>r :call VimuxRunCommand("(c \"" . bufname("%") . "\")")<cr>
vnoremap <silent> <Leader>r "vy :call VimuxRunCommand(@v)<CR>

