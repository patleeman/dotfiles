#!/usr/bin/env bash
# First time system installation script

DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"
echo "Your dotfiles are located at $DOTFILES_DIR"
echo "Starting system setup"

echo "Running initial setup scripts"
source $DOTFILES_DIR/setup/dir.sh
source $DOTFILES_DIR/setup/git.sh

if [[ $OSTYPE == darwin* ]]; then
    source $DOTFILES_DIR/setup/osx.sh
fi

if [[ $OSTYPE == linux-gnu* ]]; then
    source $DOTFILES_DIR/setup/linux.sh
fi

echo "Injecting load script into "
source $DOTFILES_DIR/utils/inject_load_script.sh

echo "Loading dotfiles"
source $LOAD_FILE

echo "Finished system setup"