#!/usr/bin/env bash

if [ ! -x "$(which yarn)" ] ; then
  echo "Please install yarn first!"
  exit 1
fi

# Nevermind, instead install parcel-bundler on a per project basis!
# yarn global add parcel-bundler