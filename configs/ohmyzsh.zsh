#!/usr/bin/env zsh
# Oh-my-zsh configuration

# Disable Oh-my-zsh compfix https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# NVM
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd nvim 

# Pyenv quiet
ZSH_PYENV_QUIET=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm pyenv direnv thefuck fzf aws vi-mode)

# vi-mode 
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
MODE_INDICATOR="%F{white}<NORMAL>%f"
INSERT_MODE_INDICATOR="%F{yellow}<INSERT>%f"

# We need to do some fuckery to get rid of the aliases ohmyzsh injects.
# https://newbedev.com/clear-or-disable-aliases-in-zsh
save_aliases=$(alias -L)
# This line loads ohmyzsh
source $ZSH/oh-my-zsh.sh

RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

# Unalias all the aliases zsh adds then restore existing aliases.
unalias -m "*"
eval $save_aliases; unset save_aliases
