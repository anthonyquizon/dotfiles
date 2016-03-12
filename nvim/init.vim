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
"Plug 'guns/vim-sexp'
Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-smooth-scroll'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/AutoComplPop'
Plug 'solarnz/thrift.vim'
Plug 'lambdatoast/elm.vim'
Plug 'endel/actionscript.vim'
Plug 'tpope/vim-fireplace'
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/TagHighlight'
call plug#end()

exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime mappings.vim
runtime settings.vim
runtime plugin/fzf.vim
runtime plugin/sexp.vim
