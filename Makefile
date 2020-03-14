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
	ln -sf $(dotfiles)/bashrc $(HOME)/.profile
	ln -sf $(dotfiles)/bashrc $(HOME)/.bashrc
	ln -sf $(dotfiles)/zshrc $(HOME)/.zshrc
	ln -sf $(dotfiles)/gitconfig $(HOME)/.gitconfig
	ln -sf $(dotfiles)/tmux.conf $(HOME)/.tmux.conf

	ln -sf $(nvim)/*.vim $(HOME)/.config/nvim

install:
	# nix
	nix-env -i git gnumake tmux wget curl neovim ripgrep fzf zsh

	# neovim plug
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# oh my zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	#tmux theme
	git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

	make setup

