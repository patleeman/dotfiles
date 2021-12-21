#!/usr/bin/env bash

export DOTFILES="${HOME}/dotfiles"

# Set nullglob to prevent error if local directory is empty.
if [ -n "$ZSH_VERSION" ]; then
    set -o nullglob
fi

if [ -n "$BASH_VERSION" ]; then
    shopt -s nullglob
fi

# Source the configuration files.
for f in $DOTFILES/{configs,local}/*; do
    if [[ -r $f ]] && [[ -f $f ]]; then
        source $f
    fi
done
