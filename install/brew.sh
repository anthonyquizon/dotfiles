
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

apps=(
    ag
    neovim
    agda
    darcs
    node
    postgresql
    mit-scheme
    haskell-stack
    smlnj
    rlwrap
    git
    swi-prolog
    leiningen
    nethack
)

brew install "${apps[@]}"
