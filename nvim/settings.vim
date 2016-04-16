
autocmd! BufEnter * silent! lcd %:p:h

colorscheme Tomorrow-Night

let g:hardtime_default_on=1 
let g:hardtime_showmsg = 1
let g:airline_powerline_fonts=1
" Neomake
autocmd! BufWritePost * Neomake

"netrw
let g:netrw_list_hide= '.git/,.DS_Store*,.*\.swp$'
let g:netrw_localrmdir='rm -r'

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

let g:NERDCustomDelimiters = {
            \ 'agda': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
            \ }
