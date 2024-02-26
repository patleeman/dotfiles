#!/usr/bin/env bash
# Environment Variables
export BLOG_DIR="${BLOG_PATH:-$HOME/workingdir/patricklee.nyc}"
export WORKING_DIR="${WORKING_DIR:-$HOME/workingdir}"
export NOTES_DIR="${NOTES_DIR:-$HOME/Dropbox/Notes}"

# Aliases
alias lg="lazygit"

# Folder aliases
alias wd='cd $WORKING_DIR'
alias df="cd $DOTFILES_DIR"
alias nd="cd $NOTES_DIR"

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"

# vim to nvim
alias vim="nvim"
alias vi="nvim"

# Quick edit
alias dotfiles='cd $DOTFILES_DIR && nvim .'
alias notes='cd $NOTES_DIR && nvim .'
alias blog='cd "$BLOG_PATH" && nvim .'

# Yabai
alias yabai_restart='launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"'
alias yabai_stop='yabai -m space --layout float'
alias yabai_start='yabai -m space --layout bsp'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias mkdir="mkdir -pv"

function ls {
	if command -v eza &>/dev/null; then
		eza -la "$@"
	else
		/bin/ls -la --color=auto "$@"
	fi
}
alias ll="/bin/ls"
