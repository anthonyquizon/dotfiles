
brew tap caskroom/cask
brew install brew-cask

apps=(
    firefox
    google-chrome
    google-drive
    vlc
)

brew cask install "${apps[@]}"
