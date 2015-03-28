#!/bin/bash

# Install homebrew and cask
if [ ! -f /usr/local/bin/brew ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install caskroom/cask/brew-cask
fi

# Install casks
for app in `cat cask-apps.txt`; do
  brew cask install $app --appdir=/Applications
done

# Install brew packages
for app in `cat brew-apps.txt`; do
  brew install $app
done
