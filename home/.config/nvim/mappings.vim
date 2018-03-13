inoremap jk <Esc>

let mapleader = "\<Space>"
let maplocalleader = ","

"stay selected when visual mode indenting
vmap < <gv
vmap > >gv

nnoremap <C-J> <C-N>
nnoremap <C-K> <C-P>

inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

"tabs
nnoremap <C-w>t :tabe<CR>
nnoremap <C-w>C :tabc<CR>
nnoremap <C-w>> gt
nnoremap <C-w>< gT

nmap <leader>F <Plug>Sneak_S
xmap <leader>F <Plug>Sneak_S
nmap <leader>f <Plug>Sneak_s
xmap <leader>f <Plug>Sneak_s
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" fugitive
nnoremap <leader>g :Gstatus<CR>

noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap ` :set relativenumber!<CR>
nnoremap <leader>ht <Esc>:call HardTimeToggle()<CR>
nnoremap <leader>1 :colorscheme Tomorrow-Night<CR>
nnoremap <leader>2 :colorscheme Tomorrow<CR>

command! Qa qa
command! WQ wq
command! Wq wq
command! W w
command! Q q
nnoremap Q <nop>

nnoremap <leader>wdd :windo diffthis<CR>
nnoremap <leader>wdf :windo diffoff<CR>

" Quickfix
noremap <leader>ll :call ToggleLocationList()<CR>
noremap <leader>l :call ToggleLocationList()<CR>
noremap <leader>ln :lN<CR>
noremap <leader>lp :lp<CR>
noremap <leader>qq :call ToggleQuickfixList()<CR>
noremap <leader>q :call ToggleQuickfixList()<CR>
noremap <leader>qn :cn<CR>
noremap <leader>qp :cp<CR>
noremap <leader>qp :cp<CR>

tnoremap <C-j><C-k> <C-\><C-n>

nnoremap <leader>u :UndotreeToggle<CR>

noremap <leader>/ :Denite grep<CR>
noremap <leader>. :Denite tag<CR>
noremap <leader>, :Denite buffer<CR>
noremap <leader><leader> :Denite file_rec/git<CR>

nnoremap <silent> <leader>t :enew \| Tnew<cr> i
nnoremap <silent> <leader>T :Ttoggle<cr>
nnoremap <silent> <leader>r :TREPLSendLine<cr>
vnoremap <silent> <leader>r :TREPLSendSelection<cr>
vnoremap <silent> <leader>R :TREPLSendSelection<cr>

nnoremap <silent> <leader>m :make<cr>

nnoremap <BS> :VimFilerBufferDir<CR>
nnoremap - :VimFiler<CR>
autocmd FileType vimfiler nunmap <buffer> <space>
autocmd FileType vimfiler vunmap <buffer> <space>

vmap U <Nop>
vmap u <Nop>
