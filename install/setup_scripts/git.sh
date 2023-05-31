#!/usr/bin/env sh

git config --global user.name "Patrick Lee"
git config --global user.email "git@patricklee.nyc"

# Make Git not complain about pushing upstream branches.
git config --global push.default current
git config --global pull.rebase true
git config --global code.editor "nvim"

# Conform Git branch names to main
git config --global init.defaultBranch main
