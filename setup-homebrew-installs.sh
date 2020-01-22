#!/usr/bin/env bash

# Install Homebrew

if [ -x "$(which brew)" ] ; then
  echo "Homebrew already installed, skipping"
else
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

brew bundle --no-lock
