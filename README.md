# Dotfiles

Personal collection of dotfiles for both mac and linux.

# Quickstart

Clone this repo into the home directory and run the install script.

```
git clone git@github.com:patleeman/dotfiles.git ~/dotfiles && source ~/dotfiles/install.sh
```

# Folders

## configs/

Stick any configurations in here that get executed for every bash session.

## local/

For local use on each machine. Stick sensitive scripts or configurations in here. Files in this folder will be sourced on every load but won't be stored in git.

## setup/

For initial environment setup scripts

# Multi-shell setup

In configs, files with the `.bash` or `.zsh` extensions get loaded in their respective environments. `.sh` files are loaded in both.

# Auto updates

Dotfiles will automatically check for updates.
