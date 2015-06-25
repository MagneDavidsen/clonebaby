#!/bin/sh

# Huge thanks to Matthew Mueller and his blogpost at http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

echo "Installing packages.."

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4 (Hello Shellshock)
brew install bash

# Install mackup
brew install mackup

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install other useful binaries
binaries=(
  python
  tree
  ack
  git
  hub
  node
)

# Install the binaries
brew install ${binaries[@]}

# Install Cask
brew install caskroom/cask/brew-cask

# Remove outdated versions from the cellar
brew cleanup

apps=(
  intellij-idea
  fantastical
  dropbox
  google-chrome
  spotify
  java
  iterm2
  virtualbox
  vagrant
  shiori
  atom
  sourcetree
  mailbox
  vlc
  slack
  qlcolorcode
  quicklook-json
  qlmarkdown
  qlstephen
)

# Adding beta versions
brew tap caskroom/versions

echo "Installing apps.."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Installing zsh"
curl -L http://install.ohmyz.sh | sh

echo "Installing zshmarks"
git clone https://github.com/jocelynmallon/zshmarks.git ~/.oh-my-zsh/custom/plugins/zshmarks

echo "Cloning my dotfiles"
git clone https://github.com/MagneDavidsen/dotfiles-zsh.git ~/.dotfiles # TODO: Check if directory exists

echo "Linking .zshrc"
ln -sf ~/.dotfiles/zshrc.zsh ~/.zshrc

echo "Linking mackup config"
ln -sf ~/.dotfiles/mackup.cfg ~/.mackup.cfg

echo "Changing some settings"
defaults write com.apple.finder AppleShowAllFiles YES
defaults write -g InitialKeyRepeat -int 5 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

#TODO: More settings

exit 0
