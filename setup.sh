dotfiles=$HOME/dotfiles/dotfiles

mkdir -p $HOME/.config/nvim/
mkdir -p $HOME/.config/guix/

ln -sf $dotfiles/bashrc $HOME/.zprofile
ln -sf $dotfiles/bashrc $HOME/.bash_profile
ln -sf $dotfiles/bashrc $HOME/.bashrc
ln -sf $dotfiles/vimrc $HOME/.vimrc
ln -sf $dotfiles/vimrc $HOME/.config/nvim/init.vim
ln -sf $dotfiles/vim/ftplugin $HOME/.config/nvim/ftplugin
ln -sf $dotfiles/mongorc.js $HOME/.mongorc.js
ln -sf $dotfiles/gitconfig $HOME/.gitconfig
ln -sf $dotfiles/tmux.conf $HOME/.tmux.conf
ln -sf $dotfiles/guile.scm $HOME/.guile
ln -sf $dotfiles/gdbinit $HOME/.gdbinit
ln -sf $dotfiles/channels.scm $HOME/.config/guix/channels.scm
