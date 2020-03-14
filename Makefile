HOME=/home/anthony
PWD=/home/anthony/dotfiles

dotfiles=$(PWD)/dotfiles
nvim=$(PWD)/nvim
nixos=$(PWD)/nixos

setup:
	mkdir -p $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim/ftdetect
	mkdir -p $(HOME)/.cabal/

	ln -sf $(dotfiles)/bashrc $(HOME)/.bash_profile
	ln -sf $(dotfiles)/profile $(HOME)/.profile
	ln -sf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf

	ln -sf $(nvim)/*.vim $(HOME)/.config/nvim

install:
	# nix
	nix-env -i git gnumake tmux wget curl neovim ripgrep fzf zsh

	# neovim plug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# oh my bash
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

	#tmux theme
	git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

	make setup

