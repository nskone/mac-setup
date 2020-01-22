#!/usr/bin/env bash

if ! which pyenv ; then
  echo "pyenv is not installed" ; exit 1
fi

PYTHON_VERSION=3.8.1

# Create /usr/local/pyenv directory
if ! [[ -d "/usr/local/pyenv" ]] ; then
  echo "Your password is required to create /usr/local/pyenv directory"
  sudo install -d -o $(whoami) -g admin /usr/local/pyenv
fi

# Setup pyenv in bash shell
if ! grep -qsF 'pyenv' $HOME/.bash_profile ; then
  cat bash_profile_pyenv >> $HOME/.bash_profile
  echo "Setup pyenv in bash shell"
fi

# Setup pyenv in fish shell
if ! grep -qsF 'pyenv' $HOME/.config/fish/config.fish ; then
  mkdir -p $HOME/.config/fish/
  cat config.fish_pyenv >> $HOME/.config/fish/config.fish
  echo "Setup pyenv in fish shell"
fi

source $HOME/.bash_profile

pyenv install --skip-existing $PYTHON_VERSION
pyenv global $PYTHON_VERSION

echo "pyenv configuration complete!"