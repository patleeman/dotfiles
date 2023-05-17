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

# https://docs.gitignore.io/install/command-line
# Generate a gitignore from a
gi() {
	curl -sL "https://www.toptal.com/developers/gitignore/api/$*"
}

git_ignore() {
	echo "Select file types to add to gitignore. Use <Tab> to mark for multiselect"
	if [ -z "$*" ]; then
		args=$(gi "list" | tr "," "\n" | fzf --multi --height 20% --reverse | tr '\n' ',' | sed 's/,$/\n/')
	else
		args="$*"
	fi

	if [ -z "$args" ]; then
		return 0
	fi

	gi "$args" >".gitignore"
	echo "Generated .gitignore file with ${args}"
}

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

# IP address
alias whatismyip='curl icanhazip.com'
function whatismylocalip {
	ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}'
}

# Small utility to list out the available ssh pub keys and copy it to your clipboard.
function copy_pub_key() {
	echo "Select the file you'd like to copy."
	PS3="Select ssh public key to copy, or 0 to exit: "
	files=("$HOME"/.ssh/*.pub)
	select file in "${files[@]}"; do
		if [[ $REPLY == "0" ]]; then
			break
		fi
		if [[ -n "$file" ]]; then
			key=$(cat "$file")
			if [[ $OSTYPE == darwin* ]]; then
				pbcopy < <(echo "$key")
			else
				# Else assumes you're on a linux system that supports xclip
				echo "$key" | xclip -selection clipboard
			fi
			echo "$file copied to system clipboard."
			break
		fi
	done
}

# Handy utility to time how long it takes to start up the shell
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timeshell() {
	shell=${1-$SHELL}
	for _ in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}
