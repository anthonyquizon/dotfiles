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
	./install/bash.sh
	./install/iptables.sh
	./install/nix.sh
	./install/nvim.sh
	./install/tmux.sh
	make setup

