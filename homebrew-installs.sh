#!/usr/bin/env bash

# Items to install

brews="awscli fish docker maven node yarn jenv firebase-cli"

casks="slack
  docker
  iterm2
  firefox google-chrome
  sublime-text intellij-idea-ce eclipse-ide
  postman
  adoptopenjdk8 adoptopenjdk9 adoptopenjdk11"

# Install Homebrew

if [ -x "$(which brew)" ] ; then
  echo "Homebrew already installed, skipping"
else
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Adding taps and running homebrew updates"
brew tap adoptopenjdk/openjdk
brew update
brew upgrade

echo "Building list of installed brews and casks"
installed_brews=$(brew list | tr -s ' ' '\n')
installed_casks=$(brew cask list | tr -s ' ' '\n')

echo "Installing brews"
for item in $brews
do
  if echo $installed_brews | grep -wq $item ; then
    echo "$item brew already installed, skipping"
  else
    brew install $item
  fi
done

echo "Installing casks"
for item in $casks
do
  if echo $installed_casks | grep -wq $item ; then
    echo "$item cask already installed, skipping"
  else
    brew cask install $item
  fi
done

echo "All done!"
