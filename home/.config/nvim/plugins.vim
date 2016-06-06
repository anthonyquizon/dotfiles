function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

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
Plug 'tpope/vim-fireplace'
Plug 'mattn/emmet-vim'
Plug 'snoe/nvim-parinfer.js'
Plug 'neovim/node-host'
Plug 'guns/vim-sexp'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'neovimhaskell/haskell-vim'
Plug 'derekelkins/agda-vim'
Plug 'raichoo/purescript-vim'
" TODO hdevtools
Plug 'XadillaX/json-formatter.vim'
call plug#end()
