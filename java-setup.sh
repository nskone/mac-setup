#!/usr/bin/env bash

if [ ! -x "$(which brew)" ] ; then
  echo "Please install homebrew first!"
  exit 1
fi

installed_brews=$(brew list | tr -s ' ' '\n')
required_brews="fish jenv"

for item in $required_brews
do
  if ! echo $installed_brews | grep -wq $item ; then
    echo "Please install $item brew first"
    exit 1
  fi
done

installed_casks=$(brew cask list | tr -s ' ' '\n')
required_casks="adoptopenjdk8 adoptopenjdk9 adoptopenjdk11"

for item in $required_casks
do
  if ! echo $installed_casks | grep -wq $item ; then
    echo "Please install $item brew cask first"
    exit 1
  fi
done

# Add jenv to fish shell (if not already added)
touch $HOME/.config/fish/config.fish
grep -qxF "status --is-interactive; and source (jenv init -|psub)" $HOME/.config/fish/config.fish || echo "status --is-interactive; and source (jenv init -|psub)" >> $HOME/.config/fish/config.fish

jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-9.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/

# Set global java versions to Java 8 for maximum compatibility
jenv global 11.0
