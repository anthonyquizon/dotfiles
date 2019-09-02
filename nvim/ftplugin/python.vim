"nnoremap <silent> -r :call VimuxRunCommand(":r")<cr>
"nnoremap <silent> -R :call VimuxRunCommand(":r")<cr>
nnoremap <silent> -e :call VimuxRunCommand("exec(open(\"" . fnamemodify(expand("%"), ":~:.") . "\").read())")<cr>
"vnoremap <silent> -r "vy :call VimuxRunCommand(@v)<CR>
