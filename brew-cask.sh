
brew tap caskroom/cask
brew install brew-cask

apps=(
    firefox
    google-chrome
    vlc
    sizeup
    steam
    java
)

brew cask install "${apps[@]}"
