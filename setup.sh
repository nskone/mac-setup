#!/usr/bin/env bash

# TODO:
# - look up other mac dev setup scripts!

# Finder settings
# TODO: Fill this in

# Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string 'PfHm'

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable “natural” scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Use scroll gesture with the Ctrl (^) modifier key to zoom
# Doesn't work on Mojave, see discussion at https://github.com/mathiasbynens/dotfiles/issues/849
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

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
  # https://github.com/gorhill/uBlock/
fi

if echo $installed_casks | grep -wq "google-chrome" ; then
  echo "Google Chrome already installed, skipping"
else
  brew cask install google-chrome
  # TODO: Any configurations? Maybe ublock-origin?
  # https://github.com/gorhill/uBlock/
fi

if echo $installed_casks | grep -wq "sublime-text" ; then
  echo "Sublime Text already installed, skipping"
else
  brew cask install sublime-text
  # TODO: Install license?
  # Yes, see discussion at:
  # https://forum.sublimetext.com/t/license-key-entry-from-the-command-line/13980/3
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





