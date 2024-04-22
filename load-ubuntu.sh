#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ]; then
    echo "DOTFILES_DIR not set, please run dotfiles install again"
    exit 1
fi

# Set value so we know dotfiles have been sourced.
export DOTFILES="$DOTFILES_DIR"

# Add scripts to path
export PATH="$DOTFILES_DIR/bin:$PATH"

source $DOTFILES_DIR/configs/aliases.sh
source $DOTFILES_DIR/configs/java.sh
source $DOTFILES_DIR/configs/tmux.sh

check_for_updates
