" TODO separate into files
call plug#begin()
Plug 'tpope/vim-sensible'
Plug '29decibel/codeschool-vim-theme'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
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

" ==== LEADER ====

"Set current buffer to directory
nnoremap <leader>vd :cd %:p:h<CR>

" Apply file
nnoremap <leader>vr :so %<CR>

nnoremap <Leader>f :Unite -start-insert file<CR>
nnoremap <leader>d :Unite -start-insert directory<CR>
nnoremap <leader>m :Unite -buffer-name=mru -start-insert file_mru<cr>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	imap <silent> <buffer> <C-k> <C-p>
	imap <silent> <buffer> <C-j> <C-n>
	nmap <silent> <buffer> <C-k> k
	nmap <silent> <buffer> <C-j> j

	imap <silent> <buffer> <C-l> <CR>
	imap <silent> <buffer> <C-h> <Plug>(unite_delete_backward_path)
	nmap <silent> <buffer> <C-l> <CR>
	nmap <silent> <buffer> <C-h> <Plug>(unite_delete_backward_path)

	imap <silent> <buffer> <Esc><Esc> <Plug>(unite_insert_leave) :q<cr>
	nmap <silent> <buffer> <Esc><Esc> <Plug>(unite_all_exit)

	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	call unite#filters#sorter_default#use(['sorter_rank'])
	call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '(\.meta$|\.tmp)')
endfunction

