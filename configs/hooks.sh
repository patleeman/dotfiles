#!/usr/bin/env bash

if [[ $OSTYPE == darwin* ]]; then
    # Node Version Manager
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    eval $(thefuck --alias)

    eval "$(direnv hook zsh)"
fi