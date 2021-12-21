#!/usr/bin/env bash

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -n "$BASH_VERSION" ] && [[ $OSTYPE == linux-gnu* ]]; then
    # Bash completion
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

if [ -n "$ZSH_VERSION" ] && [[ $OSTYPE == darwin* ]]; then
    eval "$(direnv hook zsh)"

    # zsh-completion
    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

        autoload -Uz compinit
        compinit
    fi
fi

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval $(thefuck --alias)

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
