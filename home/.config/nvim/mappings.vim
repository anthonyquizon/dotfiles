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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>

nnoremap <leader>r :so %<CR>
noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap ` :set relativenumber!<CR>
nnoremap <leader>ht <Esc>:call HardTimeToggle()<CR>
nnoremap <leader>1 :colorscheme Tomorrow-Night<CR>
nnoremap <leader>2 :colorscheme Tomorrow<CR>

"TODO fix
"vnoremap <leader>/ :s///g<LEFT><LEFT><LEFT>
"vnoremap <leader>/ y :%s/\(<C-R>"\)//g<LEFT><LEFT>
"nnoremap <leader>/ :%s/\(<c-r>=expand("<cword>")<cr>\)//g<Left><Left>
"nnoremap <leader>b/ :bufdo %s/\(<c-r>=expand("<cword>")<cr>\)//g \| update <S-LEFT><S-LEFT><LEFT><LEFT><LEFT>

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

call denite#custom#var('file_rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
	call denite#custom#var('file_rec/git', 'command',
	      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', 'prompt', '>')

call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [ '.git/', '.ropeproject/', '__pycache__/',
            \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

noremap <leader>/ :Denite grep<CR>
noremap <leader>, :Denite directory_rec<CR>
noremap <leader>. :Denite tag<CR>
noremap <leader><leader> :Denite file_rec/git<CR>
