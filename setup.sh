dotfiles=$HOME/dotfiles/dotfiles

#vim
mkdir -p $HOME/.vim/undodir
ln -sf $dotfiles/vimrc $HOME/.vimrc
