HOME=/home/anthony
PWD=/home/anthony/dotfiles

dotfiles=$(PWD)/dotfiles

.PHONY: setup
setup:
	ln -sf $(dotfiles)/bashrc $(HOME)/.bash_profile
	ln -sf $(dotfiles)/profile $(HOME)/.profile
	ln -sf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sf $(dotfiles)/vimrc $(HOME)/.vimrc
	ln -sf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf

.PHONY: install
install:
	./install/guix.sh
	./install/bash.sh
	./install/iptables.sh
	./install/tmux.sh
	make setup

