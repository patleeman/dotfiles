#!/usr/bin/env zsh

if [[ $OSTYPE == darwin* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Hooks for ZSH
eval "$(direnv hook zsh)"
eval $(thefuck --alias)