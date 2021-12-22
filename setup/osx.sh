# Main install script for macOS, tested with x86.

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

echo "Install thefuck utility"
brew install thefuck

echo "Installing vscode"
brew install --cask visual-studio-code

echo "Installing iterm2"
brew install --cask iterm2

echo "Installing Git Fork"
brew install --cask fork

echo "Installing Firefox"
brew install --cask firefox

echo "Installing Google Chrome"
brew install --cask google-chrome-canary

echo "Installing Docker"
brew install docker

echo "Installing Karabiner-Elements"
brew install --cask karabiner-elements

echo "Installing nvm & node"
brew install nvm
nvm install --lts
nvm use --lts

echo "Installing pyenv & pyenv-virtualenv"
brew install pyenv
brew install pyenv-virtualenv

echo "Installing direnv"
brew install direnv

echo "Installing awscli"
brew install awscli

echo "Installing zsh-completion"
brew install zsh-completions

echo "Installing FiraCode Font"
brew install --cask font-fira-code
