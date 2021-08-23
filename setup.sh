dotfiles=$HOME/dotfiles/dotfiles

mkdir -p $HOME/.config/nvim/

#tmux
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

#vim
mkdir -p $HOME/.vim/undodir

ln -sf $dotfiles/bashrc $HOME/.zprofile
ln -sf $dotfiles/bashrc $HOME/.bash_profile
ln -sf $dotfiles/bashrc $HOME/.bashrc
ln -sf $dotfiles/vimrc $HOME/.vimrc
ln -sf $dotfiles/vimrc $HOME/.config/nvim/init.vim
ln -sf $dotfiles/vim/ftplugin $HOME/.config/nvim/ftplugin
ln -sf $dotfiles/gitconfig $HOME/.gitconfig
ln -sf $dotfiles/tmux.conf $HOME/.tmux.conf
