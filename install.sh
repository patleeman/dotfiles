#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"
echo "DOTFILES DIR: $DOTFILES_DIR"
echo "Starting system setup"

echo "Running initial setup scripts"
source $DOTFILES_DIR/setup/dir.sh
source $DOTFILES_DIR/setup/git.sh
source $DOTFILES_DIR/setup/osx.sh
source $DOTFILES_DIR/setup/linux.sh

LOAD_COMMAND="source $LOAD_FILE"

if [[ -n "$ZSH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.zshrc; then
    echo "Installing load script in .zshrc"
    echo -n $LOAD_COMMAND >> ~/.zshrc
fi

if [[ -n "$BASH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.bashrc; then
    echo "Installing load script in .bashrc"
    echo -n $LOAD_COMMAND >> ~/.bashrc
fi

echo "Loading dotfiles"
source $LOAD_FILE

echo "Finished system setup"