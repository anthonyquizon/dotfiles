" TODO follow sym links
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'flazz/vim-colorschemes'
Plug 'guns/vim-sexp'
Plug 'osyo-manga/vim-over'
Plug 'bling/vim-airline'
Plug 'takac/vim-hardtime'
call plug#end()

exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime settings.vim
runtime plugin/fzf.vim
runtime plugin/fugitive.vim
runtime plugin/neomake.vim
runtime plugin/netrw.vim
runtime plugin/clojure.vim
runtime plugin/surround.vim
