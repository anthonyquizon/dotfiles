HOME=/home/anthony
PWD=/home/anthony/dotfiles

dotfiles=$(PWD)/dotfiles

.PHONY: setup
setup:
	ln -sf $(dotfiles)/bashrc $(HOME)/.bash_profile
	ln -sf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sf $(dotfiles)/vimrc $(HOME)/.vimrc
	ln -sf $(dotfiles)/mongorc.js $(HOME)/.mongorc.js
	ln -sf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(dotfiles)/guile.scm $(HOME)/.guile
	ln -sf $(dotfiles)/gdbinit $(HOME)/.gdbinit
	ln -sf $(dotfiles)/channels.scm $(HOME)/.config/guix/channels.scm

.PHONY: install
install:
	./install/apt.sh
	./install/guix.sh
	./install/bash.sh
	./install/tmux.sh
	./install/ufw.sh
	./install/vim.sh
	make setup
