set nu

inoremap jk <Esc>
vnoremap <Space> <Esc>

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

"Set current buffer to directory
nnoremap ,cd :cd %:p:h<CR>

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

nnoremap <Leader>T :set softtabstop=4<CR>
nnoremap <Leader>t :set softtabstop=2<CR>

nnoremap <Leader>e :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>E :set nospell<CR>
