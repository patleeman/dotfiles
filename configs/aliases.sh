#!/usr/bin/env bash

# Environment Variables
export BLOG_PATH="$HOME/workingdir/patricklee.nyc"
export WORKING_DIR="$HOME/workingdir"

# Aliases
# Remap ls to use exa for nicer output
alias ls="exa -lh"
alias tree="exa -laT"
alias cat="bat"

# Folder aliases
alias wd='cd $WORKING_DIR'

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
alias yabai_stop='yabai -m space --layout float'
alias yabai_start='yabai -m space --layout bsp'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias mkdir="mkdir -pv"
