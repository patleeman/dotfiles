# Aliases

# ls
alias ls="ls -laGpF --color=auto"
alias ll="ls -lGpF --color=auto"
alias l="ls -lGpF --color=auto"

# Folder aliases
alias wd="cd ~/workingdir"

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"
function gcp () {
    echo "$1"
    git add .
    git commit -m $1
    git push
}