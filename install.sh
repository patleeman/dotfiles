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

. install/setup_load_script.sh
. install/home.sh
. install/nvim.sh
. install/dir.sh
. install/git.sh

