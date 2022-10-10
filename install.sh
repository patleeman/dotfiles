#!/usr/bin/env sh
# First time system installation script
DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"
echo "Your dotfiles are located at $DOTFILES_DIR"
echo "Starting system setup"

echo "Which system would you like to setup?"
echo "1. MacOS [ARM]"
read -r input;
case $input in
    1) . "${DOTFILES_DIR}/install/osx_arm.zsh";;
    *)
        echo "Option not valid, exiting"
        exit 1
        ;;
esac

echo "Injecting load script"
LOAD_COMMAND=$(cat <<EOF

# Load dotfiles
export DOTFILES_DIR="$DOTFILES_DIR"
source "$LOAD_FILE"
EOF
)

if command -v zsh --version > /dev/null 2>&1 ; then
    mv ~/.zshrc ~/.zshrc.bak
    touch ~/.zshrc
    echo "$LOAD_COMMAND" > ~/.zshrc
    echo "Installed load script in ~/.zshrc"
fi

if command -v bash --version > /dev/null 2>&1 ; then
    mv ~/.bashrc ~/.bashrc.bak
    touch ~/.bashrc
    echo "$LOAD_COMMAND" > ~/.bashrc
    echo "Installed load script in ~/.bashrc"
fi