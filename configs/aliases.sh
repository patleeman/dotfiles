#!/bin/sh
# Aliases

# ls
alias ls="exa -lh"
alias tree="exa -laT"

# Folder aliases
alias wd="cd ~/workingdir"

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"
alias gd="git_diff"
alias gnb="git_new_branch"
alias gsha="git rev-parse HEAD"

# Dotfiles
alias edit_dotfiles='cd $DOTFILES_DIR && nvim'
alias notes='cd ~/Dropbox/Notes && nvim'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias mkdir="mkdir -pv"

# IP address
alias whatismyip='curl icanhazip.com'
alias whatismylocalip='get_local_ip_address'

# Fun aliases
alias weather="curl 'wttr.in?1nq'"

