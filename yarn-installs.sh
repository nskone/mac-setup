#!/usr/bin/env bash

if [ ! -x "$(which yarn)" ] ; then
  echo "Please install yarn first!"
  exit 1
fi

yarn global add parcel-bundler