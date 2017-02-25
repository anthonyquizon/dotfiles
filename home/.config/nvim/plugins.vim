function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'neovim/node-host'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'guns/vim-sexp'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'neovimhaskell/haskell-vim'
Plug 'derekelkins/agda-vim'
Plug 'raichoo/purescript-vim'
Plug 'avakhov/vim-yaml'
Plug 'luisjure/csound'
Plug 'FrigoEU/psc-ide-vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'mbbill/undotree'
Plug 'kovisoft/paredit'
Plug 'wlangstroth/vim-racket'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'luochen1990/rainbow'
call plug#end()
