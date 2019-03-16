dotfiles=$(PWD)/dotfiles

install:
	mkdir -p $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim/ftplugin
	mkdir -p $(HOME)/.config/rash

	ln -sFf $(dotfiles)/bash_profile $(HOME)/.bash_profile
	ln -sFf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sFf $(dotfiles)/eslintrc $(HOME)/.eslintrc
	ln -sFf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sFf $(dotfiles)/jshintrc $(HOME)/.jshintrc
	ln -sFf $(dotfiles)/nethackrc $(HOME)/.nethackrc
	ln -sFf $(dotfiles)/pythonrc $(HOME)/.pythonrc
	ln -sFf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf
	ln -sFf $(dotfiles)/zshrc $(HOME)/.zshrc
	ln -sFf $(dotfiles)/npmrc $(HOME)/.npmrc
	ln -sFf $(dotfiles)/tigrc $(HOME)/.tigrc
	ln -sFf $(dotfiles)/rashrc $(HOME)/.config/rash/rashrc

	ln -sFf $(PWD)/nvim/*.vim $(HOME)/.config/nvim
	ln -sFf $(PWD)/nvim/ftplugin/*.vim $(HOME)/.config/nvim/ftplugin
