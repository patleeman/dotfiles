#!/usr/bin/env bash

# Environment Variables
export BLOG_PATH="$HOME/workingdir/patricklee.nyc"
export WORKING_DIR="$HOME/workingdir"

# Aliases
# Remap ls to use exa for nicer output
alias ls="exa -lh"
alias tree="exa -laT"

# Folder aliases
alias wd='cd $WORKING_DIR'
alias projects='find $WORKING_DIR -maxdepth 1 -type d | fzf --print0 --height 20% --reverse | xargs -0 -o nvim'

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"

# vim to nvim
alias vim="nvim"
alias vi="nvim"

# Quick edit
alias dotfiles='cd $DOTFILES_DIR && nvim .'
alias notes='cd ~/Dropbox/Notes && nvim .'
alias blog='cd "$BLOG_PATH" && nvim .'

# Yabai
alias yabai_restart='launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias mkdir="mkdir -pv"
