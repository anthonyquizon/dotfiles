function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'FrigoEU/psc-ide-vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'alx741/vim-hindent'
Plug 'derekelkins/agda-vim'
Plug 'avakhov/vim-yaml'
Plug 'benekastah/neomake'
Plug 'eagletmt/neco-ghc'
Plug 'nanotech/jellybeans.vim'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'kovisoft/slimv'
Plug 'luisjure/csound'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'neovim/node-host'
Plug 'neovimhaskell/haskell-vim'
Plug 'raichoo/purescript-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'wlangstroth/vim-racket'
Plug 'bhurlow/vim-parinfer'
Plug 'brooth/far.vim'
call plug#end()
