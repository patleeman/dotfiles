#!/usr/bin/env sh

if [ -z "$DOTFILES_DIR" ]; then
	echo "DOTFILES_DIR not set, please run dotfiles install again"
	exit 1
fi

# Set value so we know dotfiles have been sourced.
export DOTFILES="$DOTFILES_DIR"

ext=""
if [ -n "$ZSH_VERSION" ]; then
	# Set nullglob to prevent error if local directory is empty.
	set -o nullglob
	ext="zsh"
elif [ -n "$BASH_VERSION" ]; then
	# shellcheck disable=SC3044
	shopt -s nullglob
	ext="bash"
fi

# Add homebrew to path
if [[ $OSTYPE == darwin* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi

# Add scripts to path
export PATH="$HOME/dotfiles/bin:$PATH"

# Source configs
for f in "$DOTFILES_DIR"{configs,local}/*.{$ext,sh}; do
	if [[ -r $f ]] && [[ -f $f ]]; then
		# shellcheck disable=SC1090
		. "$f"
	fi
done
