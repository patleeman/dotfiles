#!/usr/bin/env bash

DOTFILES_DIR=$(dirname "$0")

echo "Starting system setup"

echo "Running initial setup scripts"
source $DOTFILES_DIR/setup/dir.sh
source $DOTFILES_DIR/setup/git.sh
source $DOTFILES_DIR/setup/osx.sh

echo "Loading dotfiles"
source $DOTFILES_DIR/load.sh

echo "Finished system setup"