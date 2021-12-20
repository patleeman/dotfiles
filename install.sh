#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"
echo "DOTFILES DIR: $DOTFILES_DIR"
echo "Starting system setup"

echo "Running initial setup scripts"
source $DOTFILES_DIR/setup/dir.sh
source $DOTFILES_DIR/setup/git.sh
source $DOTFILES_DIR/setup/osx.sh

if [[ $OSTYPE == darwin* ]]; then
    echo "Installing load script"
    echo -n "export DOTFILES_DIR=${DOTFILES_DIR} && source $LOAD_FILE" >> ~/.zshrc
fi

echo "Loading dotfiles"
source $LOAD_FILE

echo "Finished system setup"