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
alias op='ls -1 $WORKING_DIR fzf --print0 --height 20% --reverse | xargs -0 -o nvim'

# Git
alias gs="git status"
alias ga="git add ."
alias gb="git branch"

# https://docs.gitignore.io/install/command-line
# Generate a gitignore from a
git_ignore() {
	curl -sL "https://www.toptal.com/developers/gitignore/api/$*"
}

# FZF Git commands
# https://github.com/junegunn/fzf/wiki/Examples#git
# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fgit_branch_checkout() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fcoc - checkout git commit
fgit_commit_checkout() {
	local commits commit
	commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
		commit=$(echo "$commits" | fzf --tac +s +m -e) &&
		git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fgit_commits_browse() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
			--bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Quick edit
alias edit_dotfiles='cd $DOTFILES_DIR && nvim'
alias notes='cd ~/Dropbox/Notes && nvim'
alias edit_blog='cd "$BLOG_PATH" && nvim'

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
