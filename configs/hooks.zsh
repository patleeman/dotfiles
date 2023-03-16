#!/usr/bin/env zsh

if [[ $OSTYPE == darwin* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

export PATH="$HOME/dotfiles/scripts:$PATH"

# Hooks for ZSH
eval "$(direnv hook zsh)"
eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZVM_VI_ESCAPE_BINDKEY=jj
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
