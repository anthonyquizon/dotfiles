dotfiles=$(PWD)/dotfiles
nvim=$(PWD)/nvim
nixos=$(PWD)/nixos

install:
	mkdir -p $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim/ftdetect
	mkdir -p $(HOME)/.cabal/

	ln -sFf $(dotfiles)/bash_profile $(HOME)/.bash_profile
	ln -sFf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sFf $(dotfiles)/eslintrc $(HOME)/.eslintrc
	ln -sFf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sFf $(dotfiles)/jshintrc $(HOME)/.jshintrc
	ln -sFf $(dotfiles)/nethackrc $(HOME)/.nethackrc
	ln -sFf $(dotfiles)/pythonrc $(HOME)/.pythonrc
	ln -sFf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf
	ln -sFf $(dotfiles)/npmrc $(HOME)/.npmrc
	ln -sFf $(dotfiles)/tigrc $(HOME)/.tigrc
	ln -sFf $(dotfiles)/cabal_config $(HOME)/.cabal/config

	ln -sFf $(nvim)/*.vim $(HOME)/.config/nvim
	ln -sFf $(nvim)/ftdetect/*.vim $(HOME)/.config/nvim/ftdetect

	ln -sFf $(nixos)/configuration.nix /etc/nixos/configuration.nix
