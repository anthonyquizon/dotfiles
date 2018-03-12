function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'neovim/node-host', { 'do': 'npm install -g neovim' }
Plug 'FrigoEU/psc-ide-vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
"Plug 'alx741/vim-hindent'
Plug 'derekelkins/agda-vim'
Plug 'avakhov/vim-yaml'
Plug 'benekastah/neomake'
Plug 'eagletmt/neco-ghc'
Plug 'nanotech/jellybeans.vim'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'jpalardy/vim-slime'
Plug 'luisjure/csound'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'wlangstroth/vim-racket'
Plug 'brooth/far.vim'
Plug 'kassio/neoterm'
Plug 'reasonml-editor/vim-reason'
Plug 'kovisoft/paredit'
Plug 'vim-scripts/taglist.vim'
Plug 'LnL7/vim-nix'
Plug 'lfe-support/vim-lfe'
Plug 'terryma/vim-multiple-cursors'
call plug#end()
