"============NOTES============"
"
" Must create ~/.vim/undodir folder 
" for persistant undo to work
"
"============================="

set nocompatible
set noswapfile
filetype off
filetype plugin indent on


"**********OS SPECIFICS**********"
"**MAC OSX**
if has('gui_macvim')
	set guifont=Inconsolata:h25

"**LINUX**
elseif has('gui_gtk2')
	set guifont=Monospace\ 16

else
"**Commandline**
	set guifont=Inconsolata:h25
	set guifont=Monospace\ 16
endif

"*******************************"


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"***********BUNDLES*************"
Bundle 'gmarik/vundle'

"**colorschemes**
Bundle 'jellybeans.vim'

"**utils**
Bundle 'vim-scripts/L9'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

"**workspace**
Bundle 'Lokaltog/vim-easymotion'
Bundle 'milkypostman/vim-togglelist'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'sjl/gundo.vim'
"Bundle 'vim-scripts/sessionman.vim'


"**Programming**
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tsaleh/vim-matchit'
"--disable for cpp 
"Bundle 'vim-scripts/AutoComplPop'
Bundle 'garbas/vim-snipmate'
Bundle 'mattn/zencoding-vim'
Bundle 'tpope/vim-fugitive'

"**nodejs/javascript**
"find better or delete?
Bundle 'myhere/vim-nodejs-complete'
"TODO code search

"**C++**
Bundle 'Rip-Rip/clang_complete'
"TODO clang indexer 
"TODO cling - clang interactive
"TODO gdb step debugging
"TODO refactoring


"**TODO install**
"grep search
"minibufexplorer
"surround
"fugitive
"Gundo

"*******************************"

"***********SETTINGS************"
colorscheme jellybeans


set guioptions-=T
set number
set tabstop=4
set shiftwidth=4
"set cindent
set mouse=a
set completeopt=menu,menuone,longest
set pumheight=15
set nowrap

set undofile
set undodir=~/.vim/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"**status line**"

set statusline=%t       "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=\ %P    "percent through file

"*******************************"


"***********MAPPINGS************"
nnoremap Y y$

"**tabs**
noremap <C-tab> :tabnext<cr>
noremap <C-S-tab> :tabprev<cr>

"**add new lines**
map <C-k> O<Esc>
map <C-j> o<Esc>
map <C-S-Enter> O<Esc>j
map <C-Enter> o<Esc>k

"**Esc**
imap <C-Space> <Esc>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
noremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>


noremap <F9> :so %<CR>

"**tabs**
map  <C-t>      :tabe<CR>
imap <C-t> <ESC>:tabe<CR>

noremap tt :tabe <CR>
noremap tw :tabc <CR>
noremap tc :tabc <CR>

"**build**
nnoremap <silent> <leader><F4>  :make<CR>

"**function mappings**



"""PLGIN MAPPINGS/OPTIONS"""

"**NERDTree**
noremap <F4>   :NERDTreeToggle<CR>


"**FuzzyFinder**
let g:fuf_modesDisable=[]
let g:fuf_mrufile_maxItem=50
let g:fuf_mrucmd_maxItem=50
let g:fuf_dataDir = '~/.vim/fuf-data'

noremap <F5>   :FufFileWithCurrentBufferDir<CR>
noremap <S-F5> :FufFileWithCurrentBufferDir!<CR>
noremap <F6>   :FufMruCmd<CR>
noremap <S-F6> :FufMruCmd!<CR>
noremap <F7>   :FufMruFile<CR>
noremap <S-F7> :FufMruFile!<CR>

"**Syntastic**
let g:syntastic_cpp_config_file = '.clang_complete' "use same file as clang_complete - its hardcoded in the plugin so conform to that
let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_check_header=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"**ClangComplete**
"let g:clang_snippets=1

"**Vim ToggleList**
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

"**GUndo**
noremap <F3> :GundoToggle<CR>

"*******************************"


"***********FUNCTIONS************"


"*******************************"
