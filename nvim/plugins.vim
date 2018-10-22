function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"TODO w0rp/ale
Plug 'FrigoEU/psc-ide-vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'derekelkins/agda-vim'
Plug 'avakhov/vim-yaml'
Plug 'benekastah/neomake'
Plug 'eagletmt/neco-ghc'
Plug 'nanotech/jellybeans.vim'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'luisjure/csound'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
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
Plug 'reasonml-editor/vim-reason-plus'
Plug 'kovisoft/paredit'
Plug 'takac/vim-hardtime'
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'LnL7/vim-nix'
call plug#end()
