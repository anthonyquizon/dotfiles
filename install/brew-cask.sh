
brew tap caskroom/cask
brew install brew-cask

apps=(
    firefox
    google-chrome
    google-drive
    vlc
    sizeup
    steam
    java
)

brew cask install "${apps[@]}"
