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

" Sneak manual key (should delete later)
nmap S <Plug>Sneak_S
xmap S <Plug>Sneak_S
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

nnoremap <leader>r :so %<CR>
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

tnoremap jk <C-\><C-n>

nnoremap <leader>u :UndotreeToggle<CR>

nmap <buffer> _ <Plug>NetrwTreeSqueeze


noremap <leader>/ :Denite grep<CR>
noremap <leader>. :Denite directory_rec/git:$HOME/Development<CR>
noremap <leader>, :Denite tag<CR>
noremap <leader><leader> :Denite file_rec/git<CR>
noremap <leader>b :Denite buffer<CR>

"let g:neoterm_position = 'horizontal'
"let g:neoterm_automap_keys = '<>tt'

nnoremap <silent> <leader>tt :Topen<cr>
nnoremap <silent> <leader>tf :TREPLSendFile<cr>
nnoremap <silent> <leader>tl :TREPLSendLine<cr>
vnoremap <silent> <leader>ts :TREPLSendSelection<cr>

nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tc :call neoterm#clear()<cr>
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>
