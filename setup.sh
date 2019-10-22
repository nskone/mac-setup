#!/usr/bin/env bash

# Finder settings
# TODO: Fill this in

# Dock settings
# TODO: Fill this in
# Remove most items from dock

# TODO: Setup secrets file that is encrypted and in GIT?

if [ -x "$(which brew)" ] ; then
  echo "Homebrew already installed, skipping"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Adding taps and running homebrew updates"
brew tap homebrew/cask-versions
brew update
brew upgrade

installed_brews=$(brew list | tr -s ' ' '\n')
installed_casks=$(brew cask list | tr -s ' ' '\n')

# Install mas-cli, which allows us to install apps from the Mac App Store from the CLI
if echo $installed_brews | grep -q "mas" ; then
  echo "mas-cli already installed, skipping"
else
  brew install mas
fi

if mas account | grep -q "Not signed in" ; then
  echo "$(tput setaf 1)Please manually log into the Mac App Store and rerun this script$(tput sgr 0)"
  exit 1
fi

installed_apps=$(mas list)

if echo $installed_casks | grep -wq "slack" ; then
  echo "Slack already installed, skipping"
else
  brew cask install slack
  open https://voxbox.slack.com/open
  open https://mercurygateteam.slack.com/open
fi

# Setup terminal
if echo $installed_casks | grep -wq "iterm2" ; then
  echo "iTerm2 already installed, skipping"
else
  brew cask install iterm2
  # TODO: Any iterm2 configuration?
fi

# TODO: Install fish and configure iterm2

# BROWSERS

if echo $installed_casks | grep -wq "firefox" ; then
  echo "Firefox already installed, skipping"
else
  brew cask install firefox
  # TODO: Any configurations? Maybe ublock-origin?
fi

if echo $installed_casks | grep -wq "google-chrome" ; then
  echo "Google Chrome already installed, skipping"
else
  brew cask install google-chrome
  # TODO: Any configurations? Maybe ublock-origin?
fi

if echo $installed_casks | grep -wq "sublime-text" ; then
  echo "Sublime Text already installed, skipping"
else
  brew cask install sublime-text
  # TODO: Install license?
fi

if echo $installed_brews | grep -wq "docker" ; then
  echo "Docker already installed, skipping"
else
  brew install docker
fi

if echo $installed_casks | grep -wq "docker" ; then
  echo "Docker app already installed, skipping"
else
  brew cask install docker
fi

if echo $installed_casks | grep -wq "java" ; then
  echo "Java already installed, skipping"
else
  brew cask install java
fi

if echo $installed_brews | grep -wq "maven" ; then
  echo "Maven already installed, skipping"
else
  brew install maven
fi

if echo $installed_casks | grep -wq "intellij-idea-ce" ; then
  echo "intellij-idea-ce already installed, skipping"
else
  brew cask install intellij-idea-ce
fi

if echo $installed_casks | grep -wq "postman" ; then
  echo "postman already installed, skipping"
else
  brew cask install postman
fi

# Configure Safari
	# Turn on favorites bar





