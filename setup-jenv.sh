#!/usr/bin/env bash

if ! which jenv ; then
  echo "jenv is not installed" ; exit 1
fi

# Setup pyenv in bash shell
if ! grep -qsF 'jenv' $HOME/.bash_profile ; then
  cat bash_profile_jenv >> $HOME/.bash_profile
  echo "Setup jenv in bash shell"
fi

# Setup jenv in fish shell
if ! grep -qsF 'jenv' $HOME/.config/fish/config.fish ; then
  mkdir -p $HOME/.config/fish/
  cat config.fish_jenv >> $HOME/.config/fish/config.fish
  echo "Setup jenv in fish shell"
fi

# Add Java versions installed with homebrew to jenv
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-9.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/

jenv global 11.0

echo "Java setup complete"
