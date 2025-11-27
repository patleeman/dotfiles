# Dotfiles

These are my Mac dotfiles

# Installation

1. Make sure to install stow `brew install stow`

```
stow home
```

2. Add to the bottom of .zshrc:

```
# Load dotfiles
source ~/.dotfiles/load.sh
```