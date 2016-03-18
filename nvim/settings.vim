" Apply file
nnoremap <leader>vr :so %<CR>
noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap <leader>o <C-^>
nnoremap <leader>d :Explore<CR>
nnoremap <leader>: :OverCommandLine<CR>
nnoremap <leader>n :set relativenumber!<CR>
nnoremap <leader>ht <Esc>:call HardTimeToggle()<CR>

nnoremap <leader>/ :%s/\(<c-r>=expand("<cword>")<cr>\)/

autocmd! BufEnter * silent! lcd %:p:h

colorscheme Tomorrow-Night

let g:hardtime_default_on=1 
let g:hardtime_showmsg = 1
let g:airline_powerline_fonts=1

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 4)<CR>
noremap <silent> <pageup> :call smooth_scroll#up(&scroll*2, 1, 4)<CR>
noremap <silent> <pagedown> :call smooth_scroll#down(&scroll*2, 1, 4)<CR>

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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

" Neomake
autocmd! BufWritePost * Neomake

"netrw
let g:netrw_list_hide= '.git/,.DS_Store*,.*\.swp$'
let g:netrw_localrmdir='rm -r'

