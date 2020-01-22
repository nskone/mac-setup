#!/usr/bin/env bash

# List of brew packages to be installed
brews="openssl@1.1 readline pyenv"

# Install Homebrew

if [ -x "$(which brew)" ] ; then
  echo "Homebrew already installed, skipping"
else
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Running homebrew updates"
brew update
brew upgrade

echo "Building list of installed brews"
installed_brews=$(brew list | tr -s ' ' '\n')

echo "Installing brews"
for item in $brews
do
  if echo $installed_brews | grep -wq $item ; then
    echo "$item brew already installed, skipping"
  else
    brew install $item
  fi
done

# Move pyenv installs to /usr/local/ instead of home dir
export PYENV_ROOT="/usr/local/pyenv"

if [[ -d "/usr/local/pyenv" ]] ; then
  echo "/usr/local/pyenv already exists"
else
  USER=$(whoami)
  echo "Your password is required to install pythonv versions to /usr/local/pyenv"
  sudo install -d -o $USER -g admin /usr/local/pyenv
fi

pyenv install --skip-existing 3.8.1

# Add pyenv to the bash path (if not already added)
if grep -qF 'pyenv' ~/.bash_profile ; then
  echo "Already found pyenv in bash_profile"
else
    # Set PYENV_ROOT
  echo -e 'export PYENV_ROOT="/usr/local/pyenv"' >> ~/.bash_profile
  # Add pyenv init
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
fi

# If fish shell is installed then also add pyenv to fish
if echo $installed_brews | grep -wq 'fish' ; then
  grep -qxF "set -x PYENV_ROOT /usr/local/pyenv" $HOME/.config/fish/config.fish || echo "set -x PYENV_ROOT /usr/local/pyenv" >> $HOME/.config/fish/config.fish
  grep -qxF "status --is-interactive; and source (pyenv init -|psub)" $HOME/.config/fish/config.fish || echo "status --is-interactive; and source (pyenv init -|psub)" >> $HOME/.config/fish/config.fish
fi

# Init pyenv in this session
eval "$(pyenv init -)"

pyenv global 3.8.1
