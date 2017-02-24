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
set undofile
set undodir=~/.nvim/undodir

colorscheme jellybeans

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
let g:surround_no_mappings = 0
let g:NERDCreateDefaultMappings = 0

autocmd filetype make setlocal noexpandtab

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif


let g:netrw_list_hide='.*\.o$,.*\.hi$,\.DS_Store$'
let g:sexp_enable_insert_mode_mappings = 0

let g:filetype_pl="prolog"

let g:slimv_lisp = '/usr/local/bin/sbcl'
let g:slimv_impl = 'sbcl'

let g:julia_blocks = 0
let g:paredit_mode = 0

" paredit messes with julia vim plugin
autocmd filetype julia let g:paredit_mode = 0 
autocmd filetype racket let g:paredit_mode = 1

let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['darkblue', 'darkgreen', 'darkcyan', 'darkmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
