#!/usr/bin/env bash

echo "Injecting load script"
LOAD_COMMAND=$(
	cat <<EOF

# Load dotfiles
export DOTFILES_DIR="$DOTFILES_DIR"
source "$LOAD_FILE"
EOF
)

if command -v zsh --version >/dev/null 2>&1; then
	mv ~/.zshrc ~/.zshrc.bak
	touch ~/.zshrc
	echo "$LOAD_COMMAND" >~/.zshrc
	echo "Installed load script in ~/.zshrc"
fi

if command -v bash --version >/dev/null 2>&1; then
	mv ~/.bashrc ~/.bashrc.bak
	touch ~/.bashrc
	echo "$LOAD_COMMAND" >~/.bashrc
	echo "Installed load script in ~/.bashrc"
fi
