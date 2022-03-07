#!/bin/sh
# Aliases

# ls
alias ls="exa -lah"
alias tree="exa -laT"

# Folder aliases
alias wd="cd ~/workingdir"

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"
alias gd="git_diff"
alias gl="git_lazy"
alias gnpr="git_new_pr"
alias gnb="git_new_branch"
alias gshal="git rev-parse HEAD"
alias gsha="git rev-parse --short HEAD"

# Dotfiles
alias edit_dotfiles='code $DOTFILES_DIR'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias psl="ps | less"
alias psg="ps | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -pv"

# IP address
alias eip='curl icanhazip.com'
alias iip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

# SSH
alias ssh_key="copy_ssh_key_to_clipboard"

# Fun aliases
alias weather="curl 'wttr.in?1nq'"

