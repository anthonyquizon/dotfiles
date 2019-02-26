function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
"Plug 'w0rp/ale'
Plug 'aqui18/ale'
Plug 'FrigoEU/psc-ide-vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'derekelkins/agda-vim'
Plug 'avakhov/vim-yaml'
Plug 'nanotech/jellybeans.vim'
Plug 'itchyny/lightline.vim'
Plug 'luisjure/csound'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
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
Plug 'justinmk/vim-sneak'
Plug 'takac/vim-hardtime'
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
Plug 'jparise/vim-graphql'
Plug 'LnL7/vim-nix'
Plug 'takac/vim-hardtime'
Plug 'lfe-support/vim-lfe'
call plug#end()
