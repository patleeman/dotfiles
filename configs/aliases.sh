#!/usr/bin/env bash
# Environment Variables
export WORKING_DIR="${WORKING_DIR:-$HOME/workingdir}"

# Aliases
alias lg="lazygit"
alias ld="lazydocker"

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
