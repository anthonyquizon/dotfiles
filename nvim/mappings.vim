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

nnoremap <silent> <leader>m :make<cr>
nnoremap <silent> <leader>w :make<cr>

nnoremap <BS> :VimFilerBufferDir<CR>
nnoremap - :enew \| VimFiler<CR>
autocmd FileType vimfiler nunmap <buffer> <space>
autocmd FileType vimfiler vunmap <buffer> <space>

vmap U <Nop>
vmap u <Nop>

nnoremap <leader>json :%!python -m json.tool<cr>

" Vimux
noremap <Leader>vv :VimuxPromptCommand<CR>
noremap <Leader>vq :VimuxCloseRunner<CR>
noremap <Leader>vz :call VimuxZoomRunner()<CR>
noremap <Leader>vz :call VimuxZoomRunner()<CR>
nnoremap <silent> <Leader>x :call VimuxRunCommand(getline('.'))<CR>
vnoremap <silent> <Leader>x "vy :call VimuxRunCommand(@v)<CR>

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

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
