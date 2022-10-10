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
alias gsha="git rev-parse HEAD"

# Replace mux and term with zellij
alias mux="zellij"
alias tmux="zellij"
alias term="zellij"

# Dotfiles
alias edit_dotfiles='code $DOTFILES_DIR'

# System
alias du="du -ach | sort -h"
alias ps="ps aux"
alias mkdir="mkdir -pv"


# IP address
alias whatismyip='curl icanhazip.com'
alias whatismylocalip='get_local_ip_address'

# SSH
alias ssh_key="copy_ssh_key_to_clipboard"

# Fun aliases
alias weather="curl 'wttr.in?1nq'"

