" TODO separate into files
" TODO follow sym links
call plug#begin()
Plug 'tpope/vim-sensible'
Plug '29decibel/codeschool-vim-theme'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'junegunn/rainbow_parentheses.vim'
" TODO sexp
call plug#end()

if has("gui_running")
    colorscheme codeschool
endif

set nu
set nowrap

inoremap jk <Esc>

let mapleader = "\<Space>"

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop> 

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop> 

vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

"stay selected when visual mode indenting
vmap < <gv
vmap > >gv


"tabs
nnoremap tc :tabc<CR>
nnoremap tn :tabe<CR>
nnoremap <C-w>> gt
nnoremap <C-w>< gT

" tab navigation like browser
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Neomake
"autocmd! BufWritePost * Neomake
"let g:neomake_javascript_enabled_makers = ['jshint']

" ==== LEADER ====

"Set current buffer to directory
nnoremap <leader>vd :cd %:p:h<CR>

" Apply file
nnoremap <leader>vr :so %<CR>

noremap … :call NERDComment(1, 'toggle')<CR>

nnoremap <leader>o <C-^>
nnoremap <leader>d :Explore<CR>

"FZF
nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>m :History<CR>
nnoremap <leader>c :History:<CR>

" TODO ag in git repo
nnoremap <leader>s :Ag<CR> 

nnoremap <leader>hd :Helptags<CR>
nnoremap <leader>hk :Maps<CR>

" TODO directory by directory search for file
function AnthoFZFFileByDirectory()
	" sink -> recusive until single filename
endfunction

function! AnthoFZFProjectFiles()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    return s:warn('Not in git repo')
  endif
  " TODO default properties eg height
  call fzf#run({
  \ 'source':  'git ls-files -c -o --exclude-standard',
  \ 'dir':     root,
  \ 'options': '-m --prompt "GitFiles> "'
  \})
endfunction

nnoremap <leader><leader>f :call AnthoFZFProjectFiles()<CR>

" TODO git root directory
" git rev-parse --show-toplevel 

" TODO FZF autocomplete
" TODO set FZF of project root 
"
autocmd BufEnter * silent! lcd %:p:h

" TODO fzf in project directory patterns
