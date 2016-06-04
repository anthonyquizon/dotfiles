
exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

runtime plugins.vim
runtime mappings.vim
runtime settings.vim
runtime plugin/fzf.vim
runtime plugin/sexp.vim
