HOME=/home/anthony
PWD=/home/anthony/dotfiles

dotfiles=$(PWD)/dotfiles

.PHONY: setup
setup:
	ln -sf $(dotfiles)/bashrc $(HOME)/.bash_profile
	ln -sf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sf $(dotfiles)/vimrc $(HOME)/.vimrc
	ln -sf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(dotfiles)/guile.scm $(HOME)/.guile
	ln -sf $(dotfiles)/gdbinit $(HOME)/.gdbinit

.PHONY: install
install:
	./install/guix.sh
	./install/bash.sh
	./install/tmux.sh
	./install/ufw.sh
	make setup

