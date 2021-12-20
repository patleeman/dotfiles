#!/usr/bin/env bash

if [[ $OSTYPE == darwin* ]]; then
    # Node Version Manager
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    eval $(thefuck --alias)


    if [ -n "$BASH_VERSION" ]; then
        # Bash completion
        [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
    fi

    if [ -n "$ZSH_VERSION" ]; then
        eval "$(direnv hook zsh)"
        if type brew &>/dev/null; then
            FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

            autoload -Uz compinit
            compinit
        fi
    fi
fi