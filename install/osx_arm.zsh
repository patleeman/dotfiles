#!/usr/bin/env zsh

# Pre-install
. "${DOTFILES_DIR}/install/setup_scripts/dir.sh"
. "${DOTFILES_DIR}/install/setup_scripts/symlinks.sh"
. "${DOTFILES_DIR}/install/setup_scripts/git.sh"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/setup_scripts/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Fix shell completion permissions
# https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-799542335
chmod -R go-w "$(brew --prefix)/share"

brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

brew install \
  mas \
  thefuck \
  tldr \
  docker \
  pyenv \
  pyenv-virtualenv \
  direnv \
  awscli \
  pandoc \
  bat \
  jq \
  neovim \
  fd \
  gnu-sed \
  ripgrep \
  lazygit \
  tmux \
  fzf \
  shellcheck \
  jless \
  eza \
  difftastic \
  saulpw/vd/visidata \
  jesseduffield/lazydocker/lazydocker


brew install --no-quarantine --cask nikitabobko/tap/aerospace
brew install --cask fork
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
brew install --cask linearmouse
brew install --cask tabby

# Install zsh-nvm
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Install InYourFace
mas install 1476964367

# Post-install
. "${DOTFILES_DIR}/install/setup_scripts/setup_load_script.sh"
. "${DOTFILES_DIR}/install/setup_scripts/work.sh"

# Set up pyenv
pyenv install 3
pyenv global 3

# https://github.com/mhinz/neovim-remote
pip3 install neovim-remote


yabai --start-service
skhd --start-service

