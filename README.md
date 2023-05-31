# Dotfiles

Personal collection of dotfiles.

# Quickstart

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/setup_scripts/HEAD/install.sh)"
```


Clone this repo into the home directory and run the appropriate install script for the system you're trying to install on.

```
git clone git@github.com:patleeman/dotfiles.git ~/dotfiles && cd install
source osx_arm.zsh
```

# Folders

## configs/

Stick any configurations in here that get executed for every shell session.

## local/

For local use on each machine. Stick sensitive scripts or configurations in here. Files in this folder will be sourced on every load but won't be stored in git.

## install/

For initial environment setup scripts. Install the various apps I use on a day to day basis.

# Multi-shell setup

In configs, files with the `.bash` or `.zsh` extensions get loaded in their respective environments. `.sh` files are loaded in both. `.sh` extension files are not actually compatible with `/bin/sh` and are written with `bash` target in mind.

# Auto updates

Dotfiles will automatically check for updates.
