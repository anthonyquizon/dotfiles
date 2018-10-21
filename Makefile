dotfiles=$(PWD)/dotfiles

install:
	mkdir -p $(HOME)/.config
	ln -s $(dotfiles)/bash_profile $(HOME)/.bash_profile
	ln -s $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -s $(dotfiles)/eslintrc $(HOME)/.eslintrc
	ln -s $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -s $(dotfiles)/jshintrc $(HOME)/.jshintrc
	ln -s $(dotfiles)/nethackrc $(HOME)/.nethackrc
	ln -s $(dotfiles)/pythonrc $(HOME)/.pythonrc
	ln -s $(dotfiles)/tmux.conf $(HOME)/.tmux.conf
	ln -s $(PWD)/nvim $(HOME)/.config/nvim
