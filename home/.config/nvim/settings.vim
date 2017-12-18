set relativenumber

syntax on
filetype on
filetype plugin indent on

set nu
set nowrap
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
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
" Neomake
au! BufWritePost * Neomake
let g:neomake_haskell_enabled_makers = ['hlint', 'ghcmod']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:haskell_indent_disable = 1

let g:neoterm_autoinsert = 0
let g:neoterm_split_on_tnew = 1
let g:neoterm_use_relative_path = 1
let g:neoterm_position = 'vertical'

"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

"netrw
let g:netrw_list_hide= '.git/,.DS_Store*,.*\.swp$'
let g:netrw_localrmdir='rm -r'

augroup BgHighlight
    au!
    au WinEnter * set cul
    au WinLeave * set nocul
augroup END

let g:NERDCustomDelimiters = {
            \ 'agda': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
            \ 'haskell': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
            \ 'hy': { 'left': ';;' },
            \ 'iad': { 'left': ';;' },
            \ 'csound': { 'left': ';;', 'leftAlt': '/*', 'rightAlt': '*/' },
            \ }

let g:deoplete#enable_at_startup = 1
let g:surround_no_mappings = 0
let g:NERDCreateDefaultMappings = 0

au filetype make setlocal noexpandtab

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:netrw_list_hide='.*\.o$,.*\.hi$,\.DS_Store$'
let g:sexp_enable_insert_mode_mappings = 0

let g:filetype_pl="prolog"

let g:paredit_mode = 0
let g:merlin_completion_dwim = 0

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

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'relativepath' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" paredit messes with julia vim plugin
au BufNewFile,BufRead *.z3 set filetype=lisp
au BufNewFile,BufRead *.sld set filetype=scheme
au BufNewFile,BufRead *.re set filetype=reason
au BufNewFile,BufRead *.rei set filetype=reason
au filetype lisp let g:paredit_mode = 1
au filetype julia let g:paredit_mode = 0 
au filetype racket let g:paredit_mode = 1
au filetype clojure let g:paredit_mode = 1
au filetype scheme let g:paredit_mode = 1
au filetype hy call PareditInitBuffer()
au filetype hy let g:paredit_mode=1
au filetype iad call PareditInitBuffer()
au filetype iad let g:paredit_mode=1
au filetype racket :RainbowToggleOn
au FileType coq call coquille#FNMapping()

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

call denite#custom#var('file_rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', 'prompt', '>')

call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [ '.git/', '.ropeproject/', '__pycache__/', 'build/',
            \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

au BufRead,BufNewFile *.hy set filetype=hy
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let g:vimfiler_as_default_explorer = 1

