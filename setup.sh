cd "$(dirname "$0")"

mkdir -pv $HOME/.vim/undodir
ln -svf $PWD/dotfiles/vimrc $HOME/.vimrc
