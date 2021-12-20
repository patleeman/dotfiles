#!/usr/bin/env bash

DOTFILES_DIR="${HOME}/dotfiles"

for f in $DOTFILES_DIR/configs/*; do source $f; done
for f in $DOTFILES_DIR/local/*; do source $f; done