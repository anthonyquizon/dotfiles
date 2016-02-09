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
Plug 'osyo-manga/vim-over'
Plug 'bling/vim-airline'
Plug 'takac/vim-hardtime'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-smooth-scroll'
Plug 'justinmk/vim-sneak'
Plug 'lambdatoast/elm.vim'
call plug#end()

exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime settings.vim
runtime plugin/fzf.vim
runtime plugin/sexp.vim
