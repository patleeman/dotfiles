#!/usr/bin/env zsh

# Install Applications
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Fix shell completion permissions
# https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-799542335
chmod -R go-w "$(brew --prefix)/share"

brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

echo "Install thefuck utility"
brew install thefuck

echo "Installing vscode"
brew install --cask visual-studio-code

echo "Installing Git Fork"
brew install --cask fork

echo "Installing Firefox"
brew install --cask firefox

echo "Installing Docker"
brew install docker

echo "Installing nvm & node"
brew install nvm
nvm install --lts
nvm use --lts
# Set default node version for system
nvm alias default node

npm install -g tldr

echo "Installing pyenv & pyenv-virtualenv"
brew install pyenv
brew install pyenv-virtualenv

echo "Installing direnv"
brew install direnv

echo "Installing awscli"
brew install awscli

echo "Installing FiraCode Font"
brew install --cask font-fira-code

echo "Installing Pandoc"
brew install pandoc

echo "Installing exa"
brew install exa

echo "Installing HTTPie"
brew install httpie

echo "Installing jq"
brew install jq

echo "Installing InYourFace"
mas install 1476964367

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
