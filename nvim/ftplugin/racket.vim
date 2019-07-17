
function! CurrentCharacter()
  echo matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

nnoremap <silent> -r :call VimuxRunCommand(",rr " . fnamemodify(expand("%"), ":~:."))<cr>
nnoremap <silent> -R :call VimuxRunCommand("(require \"" . fnamemodify(expand("%"), ":~:.") . "\")")<cr>
nnoremap <silent> -e :call VimuxRunCommand(",en " . fnamemodify(expand("%"), ":~:."))<cr>
nnoremap <silent> -t :call VimuxRunCommand("(require (submod \"" . fnamemodify(expand("%"), ":~:.") . "\" test))")<cr>
vnoremap <silent> -r "vy :call VimuxRunCommand(@v)<CR>

"<ESC> go to normal mode
"l     go to first character (escape goes back one chacacter for some reason)
"v     visual select
"i     inner modifier
"w     word (as in viw select inner word)
autocmd VimEnter * inoremap <buffer> ( <ESC>lviw:call PareditWrapSelection('(', ')')<CR>i
