
exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime plugins.vim
runtime functions.vim
runtime mappings.vim
runtime settings.vim
runtime plugins/fzf.vim
runtime plugins/sexp.vim

