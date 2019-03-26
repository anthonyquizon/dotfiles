function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/unite.vim'
Plug 'benmills/vimux'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
call plug#end()

syntax on
filetype on
filetype plugin indent on

set relativenumber
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
set nobackup

colorscheme jellybeans

augroup BgHighlight
    au!
    au WinEnter * set cul
    au WinLeave * set nocul
augroup END

let g:deoplete#enable_at_startup = 1
let g:surround_no_mappings = 0

au filetype make setlocal noexpandtab

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
      \ }
      \ }

let g:sneak#label = 1

let g:list_of_normal_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_ignore_buffer_patterns = [".git/.*", "**/.git/.*"]

hi CursorLine ctermbg=236

inoremap jk <Esc>

let mapleader = "\<Space>"
let maplocalleader = ","

"stay selected when visual mode indenting
vmap < <gv
vmap > >gv

vnoremap <leader>s "vy :%s/<C-R>v//g<Left><Left>
nnoremap <leader>s :%s/<C-R><C-W>//g<Left><Left>

"tabs
nnoremap <C-w>t :tabe<CR>
nnoremap <C-w>C :tabc<CR>
nnoremap <C-w>> gt
nnoremap <C-w>< gT

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"ace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap ` :set relativenumber!<CR>
nnoremap <leader>ht <Esc>:call HardTimeToggle()<CR>

command! Qa qa
command! WQ wq
command! Wq wq
command! W w
command! Q q
nnoremap Q <nop>

noremap <silent> <C-h> :Defx -new=true `expand('%:p:h')` -search=`expand('%:p')` <CR>
noremap <silent> <BS> :Defx -new=true `expand('%:p:h')` -search=`expand('%:p')` <CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> <C-h>
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <BS>
  \ defx#do_action('redraw')
endfunction

vmap U <Nop>
vmap u <Nop>

nnoremap <leader>g :Gstatus<CR>

" Vimux
noremap - :VimuxRunCommand('')<CR>
noremap _ :VimuxPromptCommand<CR>

noremap <silent> <leader>/ :Denite -buffer-name=grep -default-action=quickfix grep:::!<CR><CR>
noremap <leader><leader> :Denite file_rec<CR>
nnoremap <silent> \ :<C-u>Denite -winheight=10 -cursor-wrap=true -buffer-name=search -auto-highlight line<CR>
nnoremap <silent> <leader>. :Denite command<CR>

let g:fruzzy#usenative = 1

call denite#custom#source('grep',
\ 'converters', ['converter/abbr_word'])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('file_rec', 'command', 
      \ ['ag', '-l', '--nocolor', ''])

call denite#custom#option('default', 'prompt', '>')

call denite#custom#map(
            \ 'insert',
            \ '<C-n>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-p>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)

call denite#custom#map(
            \ 'insert',
            \ '<C-u>',
            \ '<denite:scroll_page_backwards>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-d>',
            \ '<denite:scroll_page_forwards>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ 'jk',
            \ '<denite:enter_mode:normal>',
            \ 'noremap'
            \)


:command FormatJson %!python -m json.tool
:command LightTheme colorscheme shine

" shuffle line one up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


" ==== Parens (From Paredit) ====

" Skip matches inside string or comment or after '\'
let s:skip_sc = '(synIDattr(synID(line("."), col("."), 0), "name") =~ "[Ss]tring\\|[Cc]omment\\|[Ss]pecial\\|clojureRegexp\\|clojurePattern" || getline(line("."))[col(".")-2] == "\\")'

" Find opening matched character
function! PareditFindOpening( open, close, select )
    let open  = escape( a:open , '[]' )
    let close = escape( a:close, '[]' )
    call searchpair( open, '', close, 'bW', s:skip_sc )
    if a:select
        call searchpair( open, '', close, 'W', s:skip_sc )
        let save_ve = &ve
        set ve=all 
        normal! lvh
        let &ve = save_ve
        call searchpair( open, '', close, 'bW', s:skip_sc )
        if &selection == 'inclusive'
            " Trim last character from the selection, it will be included anyway
            normal! oho
        endif
    endif
endfunction

" Find closing matched character
function! PareditFindClosing( open, close, select )
    let open  = escape( a:open , '[]' )
    let close = escape( a:close, '[]' )
    if a:select
        let line = getline( '.' )
        if line[col('.')-1] != a:open
            normal! h
        endif
        call searchpair( open, '', close, 'W', s:skip_sc )
        call searchpair( open, '', close, 'bW', s:skip_sc )
        normal! v
        call searchpair( open, '', close, 'W', s:skip_sc )
        if &selection != 'inclusive'
            normal! l
        endif
    else
        call searchpair( open, '', close, 'W', s:skip_sc )
    endif
endfunction

" Returns the nearest opening character to the cursor
" Used for smart jumping in Clojure
function! PareditSmartJumpOpening( select )
    let [paren_line, paren_col] = searchpairpos('(', '', ')', 'bWn', s:skip_sc)
    let [bracket_line, bracket_col] = searchpairpos('\[', '', '\]', 'bWn', s:skip_sc)
    let [brace_line, brace_col] = searchpairpos('{', '', '}', 'bWn', s:skip_sc)
    let paren_score = paren_line * 10000 + paren_col
    let bracket_score = bracket_line * 10000 + bracket_col
    let brace_score = brace_line * 10000 + brace_col
    if (brace_score > paren_score || paren_score == 0) && (brace_score > bracket_score || bracket_score == 0) && brace_score != 0
	call PareditFindOpening('{','}', a:select)
    elseif (bracket_score > paren_score || paren_score == 0) && bracket_score != 0
	call PareditFindOpening('[',']', a:select)
    else
	call PareditFindOpening('(',')', a:select)
    endif
endfunction

function! PareditSmartJumpClosing( select )
    let [paren_line, paren_col] = searchpairpos('(', '', ')', 'Wn', s:skip_sc)
    let [bracket_line, bracket_col] = searchpairpos('\[', '', '\]', 'Wn', s:skip_sc)
    let [brace_line, brace_col] = searchpairpos('{', '', '}', 'Wn', s:skip_sc)
    let paren_score = paren_line * 10000 + paren_col
    let bracket_score = bracket_line * 10000 + bracket_col
    let brace_score = brace_line * 10000 + brace_col
    if (brace_score < paren_score || paren_score == 0) && (brace_score < bracket_score || bracket_score == 0) && brace_score != 0
	call PareditFindClosing('{','}', a:select)
    elseif (bracket_score < paren_score || paren_score == 0) && bracket_score != 0
	call PareditFindClosing('[',']', a:select)
    else
	call PareditFindClosing('(',')', a:select)
    endif
endfunction


nnoremap <buffer> <silent> (  :<C-U>call PareditSmartJumpOpening(0)<CR>
nnoremap <buffer> <silent> )  :<C-U>call PareditSmartJumpClosing(0)<CR>

vnoremap <buffer> <silent> (  <Esc>:<C-U>call PareditSmartJumpOpening(1)<CR>
vnoremap <buffer> <silent> )  <Esc>:<C-U>call PareditSmartJumpClosing(1)<CR>


