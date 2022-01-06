#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"

if [[ ! $LOAD_FILE ]]; then
  echo "ERROR: LOAD_FILE not set"
  exit 1
fi

if [[ ! $DOTFILES_DIR ]]; then
  echo "ERROR: DOTFILES_DIR not set"
  exit 1
fi

LOAD_COMMAND=$(cat <<EOF


# Load dotfiles
export DOTFILES_DIR="$DOTFILES_DIR"
source "$LOAD_FILE"
EOF
)

# shellcheck disable=SC2016
CHECK_COMMAND='source "$LOAD_FILE"'

if [[ -n "$ZSH_VERSION" ]] && ! grep -Fq "$CHECK_COMMAND" ~/.zshrc; then
    cp ~/.zshrc ~/.zshrc.bak
    echo -n "$LOAD_COMMAND" > ~/.zshrc
    echo "Installed load script in ~/.zshrc"

elif [[ -n "$BASH_VERSION" ]] && ! grep -Fq "$CHECK_COMMAND" ~/.bashrc; then
    cp ~/.bashrc ~/.bashrc.bak
    echo -n "$LOAD_COMMAND" > ~/.bashrc
    echo "Installed load script in ~/.bashrc"

else
    echo -n "Load script not installed in ~/.zshrc nor ~/.bashrc. Please manually add the following lines to one of those files:"
    printf "\n%s\n" "$LOAD_COMMAND"
fi