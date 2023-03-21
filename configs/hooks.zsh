#!/usr/bin/env zsh

if [[ $OSTYPE == darwin* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

export PATH="$HOME/dotfiles/scripts:$PATH"


