set nu
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nohlsearch
set smartcase
set cursorline
set relativenumber

inoremap jk <Esc>

let mapleader = "\<Space>"

syntax on
filetype plugin indent on

"stay selected when visual mode indenting
vmap < <gv
vmap > >gv

"tabs
nnoremap <C-w>t :tabe<CR>
nnoremap <C-w>C :tabc<CR>
nnoremap <C-w>\> gt
nnoremap <C-w>\< gT

"Set current buffer to directory
nnoremap <leader>vd :cd %:p:h<CR>

" Apply file
nnoremap <leader>vr :so %<CR>

noremap <leader>; :call NERDComment(1, 'toggle')<CR>


nnoremap <leader>o <C-^>
nnoremap <leader>d :Explore<CR>
nnoremap <leader>: :OverCommandLine<CR>
nnoremap <leader>n :set relativenumber!<CR>
nnoremap <leader>he <Esc>:call ToggleHardMode()<CR>

autocmd! BufEnter * silent! lcd %:p:h
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

au WinLeave * set norelativenumber
au FocusLost * set norelativenumber

au WinEnter * set relativenumber
au FocusGained * set relativenumber
