call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'takac/vim-hardtime'
Plug 'terryma/vim-smooth-scroll'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-fireplace'
Plug 'mattn/emmet-vim'
Plug 'snoe/nvim-parinfer.js'
Plug 'neovim/node-host'
Plug 'guns/vim-sexp'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'neovimhaskell/haskell-vim'
call plug#end()

exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime mappings.vim
runtime settings.vim
runtime plugin/fzf.vim
runtime plugin/sexp.vim
