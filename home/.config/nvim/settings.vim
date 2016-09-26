set relativenumber

syntax on
filetype plugin indent on

autocmd! BufEnter * silent! lcd %:p:h

set nu
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nohlsearch
set ignorecase
set smartcase
set cursorline
set noswapfile

colorscheme Tomorrow-Night

let g:hardtime_default_on=0
let g:hardtime_showmsg = 1
let g:airline_powerline_fonts=1
" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_haskell_enabled_makers = ['hlint', 'ghcmod']

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
            \ 'haskell': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
            \ 'csound': { 'left': ';;', 'leftAlt': '/*', 'rightAlt': '*/' },
            \ }

let g:deoplete#enable_at_startup = 1
let g:surround_no_mappings = 1
let g:NERDCreateDefaultMappings = 0

autocmd filetype make setlocal noexpandtab

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

au BufRead,BufNewFile *.lvl set filetype=yaml

let g:netrw_list_hide='.*\.o$,.*\.hi$,\.DS_Store$'
let g:paredit_mode = 0
let g:sexp_enable_insert_mode_mappings = 0

set rtp^="/Users/anthony/.opam/system/share/ocp-indent/vim"
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

let g:filetype_pl="prolog"
