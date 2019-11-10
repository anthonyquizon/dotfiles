
" NOTE: fixes and issue with paredit.vim loading
autocmd BufRead,BufNewFile *.jl
      \ let g:paredit_mode = 0 |
      \ call PareditInitBuffer()

" NOTE: restores paredit on leaving jl buffer
autocmd BufLeave *.jl
      \ let g:paredit_mode = 1 |
      \ call PareditInitBuffer()
