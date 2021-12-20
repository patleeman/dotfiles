#!/usr/bin/env bash

DOTFILES_DIR=$(dirname "$0")

echo "Starting system setup"

echo "Setting up working directory"
mkdir ~/workingdir

echo "Loading dotfiles"
source $DOTFILES_DIR/load.sh

if [[ $OSTYPE == darwin* ]]; then
    echo "Setting up OSX"
    source $DOTFILES_DIR/setup/osx.sh
fi

echo "Finished system setup"