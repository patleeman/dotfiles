#!/usr/bin/env bash

if [ -z "$DOTFILES_DIR" ] ; then
    echo "DOTFILES_DIR not set, please run dotfiles install again"
fi

# Set value so we know dotfiles have been sourced.
export DOTFILES="true"

# Set nullglob to prevent error if local directory is empty.
if [ -n "$ZSH_VERSION" ]; then
    set -o nullglob
    for f in $DOTFILES_DIR/{configs,local}/*.zsh; do
        if [[ -r $f ]] && [[ -f $f ]]; then
            source $f
        fi
    done
fi

if [ -n "$BASH_VERSION" ]; then
    shopt -s nullglob
    for f in $DOTFILES_DIR/{configs,local}/*.bash; do
        if [[ -r $f ]] && [[ -f $f ]]; then
            source $f
        fi
    done
fi

for f in $DOTFILES_DIR/{configs,local}/*.sh; do
    if [[ -r $f ]] && [[ -f $f ]]; then
        source $f
    fi
done

# Check for updates
# TODO: Figure out how we can check for updates lazily, this adds about half a second to shell startup time.
update_dotfiles
