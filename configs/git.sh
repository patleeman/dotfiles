#!/usr/bin/env bash

# Git commit push for the lazy person
function git_lazy() {
	git add .
	git commit -m "$1"
	git push
}

# https://gist.github.com/antongrbin/14a97f99a32fce4f176b198395ef1903
# Push the current branch to the origin and open the new PR for that branch in the
# github UI.
# If called with arguments, for example 'newpr add the new function', it will first
# commit changes with 'add the new function' as the commit message.
function git_new_pr {
	branch=$(git rev-parse --abbrev-ref HEAD)
	if [ $# -ne 0 ]; then
		git commit -a -m "$*"
	fi
	if [ "$branch" = "master" ]; then
		echo "don't do this on master."
	else
		if [ -z "$(git status --porcelain)" ]; then
			git push --set-upstream origin "$branch"
			repo=$(git remote -v | head -n1 | cut -f2 -d'/' | cut -f1 -d'.')
			open "https://github.com/noom/$repo/pull/new/$branch"
		else
			git status
			echo
			echo "newpr: Did u forgot to commit changes?"
		fi
	fi
}

# Creates a new feature branch off of master.
# Usage: 'newbranch min-1696/first'
function git_new_branch {
	if [ -z "$(git status --porcelain)" ]; then
		git checkout master
		git pull
		git checkout -b "$USER/$1"
	else
		git status
		echo
		echo "newbranch: Aborting due to dirty git state."
	fi
}

# Handy utility that opens up git difftool in vscode if the number
# of files changed is small, otherwise just show a regular git diff.
function git_diff {
	NUM_CHANGES=$(git whatchanged -1 --format=oneline | wc -l)
	if [ "$NUM_CHANGES" -gt "5" ]; then
		git diff
	else
		git difftool -y
	fi
}

# https://docs.gitignore.io/install/command-line
# Generate a gitignore from a
function git_ignore {
	curl -sL https://www.toptal.com/developers/gitignore/api/$@
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
