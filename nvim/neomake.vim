
" Neomake
let g:neomake_javascript_enabled_makers = ['jshint'] " TODO change to jshint and set PATH variable
autocmd! BufWritePost * Neomake
