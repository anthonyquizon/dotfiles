inoremap jk <Esc>

let mapleader = "\<Space>"

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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

nnoremap <leader><leader><leader> :so %<CR>
noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap <leader>o <C-^>
nnoremap <leader>d :Explore<CR>
nnoremap <leader>: :OverCommandLine<CR>
nnoremap ` :set relativenumber!<CR>
nnoremap <leader>ht <Esc>:call HardTimeToggle()<CR>
nnoremap <leader>1 :colorscheme Tomorrow-Night<CR>
nnoremap <leader>2 :colorscheme Tomorrow<CR>

vnoremap <leader><leader>/ :s///g<LEFT><LEFT><LEFT>
vnoremap <leader>/ y :%s/\(<C-R>"\)//g<LEFT><LEFT>
nnoremap <leader>/ :%s/\(<c-r>=expand("<cword>")<cr>\)//g<Left><Left>
nnoremap <leader>b/ :bufdo %s/\(<c-r>=expand("<cword>")<cr>\)//g \| update <S-LEFT><S-LEFT><LEFT><LEFT><LEFT>

:command! -nargs=+ SearchAndReplace :call SearchAndReplace(<f-args>)
:command! -nargs=+ Search :call Search(<f-args>)
nnoremap <leader>./ :SearchAndReplace 
" TODO highlighted word
nnoremap <leader><leader>s :Search 
nnoremap <leader>.s :Search 
" TODO argument list

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 4)<CR>
noremap <silent> <pageup> :call smooth_scroll#up(&scroll*2, 1, 4)<CR>
noremap <silent> <pagedown> :call smooth_scroll#down(&scroll*2, 1, 4)<CR>

command! Qa qa
command! WQ wq
command! Wq wq
command! W w
command! Q q
nnoremap Q <nop>

nnoremap <leader>d :Explore<CR>

noremap <leader>'d <Plug>Dsurround
noremap <leader>'c <Plug>Csurround
noremap <leader>'C <Plug>CSurround
"nmap <leader>'y <Plug>Ysurround
"nmap <leader>Y  <Plug>YSurround
"TODO
"nmap yss <Plug>Yssurround
"nmap ySs <Plug>YSsurround
"nmap ySS <Plug>YSsurround
xmap <leader>'   <Plug>VSurround
xmap <leader>'g <Plug>VgSurround

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



