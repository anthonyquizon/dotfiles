function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'benmills/vimux'
Plug 'aqui18/paredit'
Plug 'aqui18/coquille'
Plug 'derekelkins/agda-vim'
Plug 'let-def/vimbufsync' "Dependency of coquille
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
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
set nopaste
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

au filetype make setlocal noexpandtab

let g:deoplete#enable_at_startup = 1
let g:surround_no_mappings = 0
let g:netrw_localrmdir='rm -r'
let g:netrw_list_hide= '.*\.swp$,.stack-work'
let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}
let g:Lf_UseCache = 0 
let g:Lf_UseMemoryCache = 0
let g:Lf_UseVersionControlTool = 0

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

" ===== NETRW ======
let g:netrw_banner = 0

function! NetrwKeyMaps()
  nmap <buffer> h -
  nmap <buffer> l <ENTER>
endfunction

augroup netrw_maps
  autocmd!
  autocmd filetype netrw call NetrwKeyMaps()
augroup END
"==================

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
noremap -<leader> :call VimuxSendText(getline('.') . "\n")<CR>
noremap _<leader> :call VimuxSendText(getline('.')) . "\n"<CR>
vnoremap -<leader> :call VimuxSendVisualText()<CR>
vmap _<leader> -<leader>

noremap <silent> <leader>/ :Leaderf rg<CR>
noremap <silent> <leader>. :Leaderf mru<CR>
noremap <leader><leader> :Leaderf file<CR>

:command! FormatJson %!python -m json.tool
:command! LightTheme colorscheme shine

inoremap <C-o> <C-k>


" shuffle line one up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


let g:ale_linters = {'javascript': ['eslint', 'flow']}

autocmd BufRead,BufNewFile *.pl set filetype=prolog
autocmd BufRead,BufNewFile *.v set filetype=coq
autocmd BufRead,BufNewFile *.rkt set filetype=racket
autocmd BufRead,BufNewFile *.lfe set filetype=lisp


nmap <silent> <leader>> :ALENextWrap<cr>
nmap <silent> <leader>< :ALEPreviousWrap<cr>

