#!/usr/bin/env zsh

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Fix shell completion permissions
# https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-799542335
chmod -R go-w "$(brew --prefix)/share"

brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

brew install \
  thefuck \
  tldr \
  docker \
  nvm \
  pyenv \
  pyenv-virtualenv \
  direnv \
  awscli \
  pandoc \
  exa \
  jq \
  neovim \
  ripgrep \
  lazygit \
  tmux \
  fzf \
  shellcheck \
  koekeishiya/formulae/yabai \
  iterm2
brew install --cask fork
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
brew install --cask linearmouse
brew install --cask alacritty

# Set up node
nvm install --lts
nvm use --lts
nvm alias default node

# Set up pyenv
pyenv install 3
pyenv global 3

# Install InYourFace
mas install 1476964367

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# https://github.com/mhinz/neovim-remote
pip3 install neovim-remote
