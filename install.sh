#!/usr/bin/env sh
# First time system installation script

DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"
echo "Your dotfiles are located at $DOTFILES_DIR"
echo "Starting system setup"

echo "Running initial setup scripts"
# shellcheck disable=SC1091
source "$DOTFILES_DIR/setup/dir.sh"
# shellcheck disable=SC1091
source "$DOTFILES_DIR/setup/git.sh"

# macOS only install
if [[ $OSTYPE == darwin* ]]; then
    # shellcheck disable=SC1091
    source "$DOTFILES_DIR/setup/osx.sh"

    # Deploy settings
    source "$DOTFILES_DIR/setup/osx_settings.zsh"
    deploy_settings
fi

# Linux only install
is_ubuntu=$(lsb_release -d 2> /dev/null | grep -i ubuntu > /dev/null)
if [[ $OSTYPE == linux-gnu* ]] && $is_ubuntu; then
    echo "Installing minimal setup for headless environment."
    # shellcheck disable=SC1091
    source "$DOTFILES_DIR/setup/ubuntu_headless.sh"

    if [[ -n "$DESKTOP_SESION" ]]; then
        echo "Desktop environment detected, installing additional software."
        # shellcheck disable=SC1091
        source "$DOTFILES_DIR/setup/ubuntu_desktop.sh"
    fi
fi

echo "Injecting load script"
# shellcheck disable=SC1090
source "${DOTFILES_DIR}setup/inject_load_script.sh"

echo "Finished system setup"
