
" Neomake
let g:neomake_javascript_enabled_makers = ['jshint']
autocmd! BufWritePost * Neomake

autocmd! BufEnter * silent! lcd %:p:h
