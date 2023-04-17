dotfiles=$HOME/dotfiles/dotfiles

#tmux
if [ ! -d ~/.tmux-themepack ]; then
    git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi

#vim
mkdir -p $HOME/.vim/undodir

# install plug in neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -sf $dotfiles/bashrc $HOME/.zprofile
ln -sf $dotfiles/bashrc $HOME/.bash_profile
ln -sf $dotfiles/bashrc $HOME/.bashrc
ln -sf $dotfiles/vimrc $HOME/.vimrc
ln -sf $dotfiles/alacritty.yml $HOME/.config/alacritty.yml
ln -sf $dotfiles/gitconfig $HOME/.gitconfig
ln -sf $dotfiles/tmux.conf $HOME/.tmux.conf
