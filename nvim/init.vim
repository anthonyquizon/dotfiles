function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
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
Plug 'jparise/vim-graphql'
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
let g:netrw_localrmdir='rm -r'

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

function! VisualSelectionLines()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return lines
endfunction

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

noremap <silent> <BS> :Explore<CR>
vmap U <Nop>
vmap u <Nop>


function! VimuxSendVisualText() range
  let lines = join(VisualSelectionLines(), "\n") . "\n"
  call VimuxSendText(lines)
endfunction

nnoremap <leader>g :Gstatus<CR>

" Vimux
noremap -- :call VimuxOpenRunner()<CR>
noremap -_ :VimuxPromptCommand<CR>
noremap __ :VimuxPromptCommand<CR>
noremap <leader>- :call VimuxSendText(getline('.') . "\n")<CR>
noremap <leader>_ :call VimuxSendText(getline('.')) . "\n"<CR>
vnoremap <leader>- :call VimuxSendVisualText()<CR>
vmap <leader>_ <leader>-

noremap <silent> <leader>/ :Leaderf rg<CR>
noremap <silent> <leader>. :Leaderf mru<CR>
noremap <leader><leader> :Leaderf file<CR>

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


nnoremap <silent> (  :<C-U>call PareditSmartJumpOpening(0)<CR>
nnoremap <silent> )  :<C-U>call PareditSmartJumpClosing(0)<CR>

vnoremap <silent> (  <Esc>:<C-U>call PareditSmartJumpOpening(1)<CR>
vnoremap <silent> )  <Esc>:<C-U>call PareditSmartJumpClosing(1)<CR>

let g:ale_linters = {'javascript': ['eslint', 'flow']}

autocmd BufRead,BufNewFile *.pl set filetype=prolog
autocmd BufRead,BufNewFile *.rkt set filetype=racket


let g:netrw_banner = 0

augroup netrw_maps
  autocmd!
  autocmd filetype netrw call NetrwKeyMaps()
augroup END

function NetrwKeyMaps()
  nmap <buffer> h -
  nmap <buffer> l <ENTER>
  nmap <buffer> J %
  nmap <buffer> K d
endfunction

nmap <silent> <leader>> :ALENextWrap<cr>
nmap <silent> <leader>< :ALEPreviousWrap<cr>

