# Main install script for debian based distributions
# Tested with Pop!_OS 20.10

sudo apt update
# sudo apt -y upgrade

sudo apt install -y curl

echo "Install thefuck utility"
sudo apt install -y thefuck

echo "Installing vscode"
sudo snap install --classic code

echo "Installing flatpack"
sudo apt install -y flatpak

echo "Installing firefox"
flatpak install -y flathub org.mozilla.firefox

echo "Installing Docker"
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing nvm & nodejs"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts
nvm use --lts

echo "Installing pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo "Installing direnv"
sudo apt install -y direnv

echo "Installing awscli"
sudo apt install -y awscli

echo "Installing Bash-it"
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

echo "Installing bash-completion"
sudo apt install -y bash-completion

echo "Installing FiraCode Font"
sudo apt install fonts-firacode

echo "Installing xcopy xsel"
sudo apt install xclip xsel

echo "Installing Pandoc"
wget https://github.com/jgm/pandoc/releases/download/2.16.2/pandoc-2.16.2-linux-amd64.tar.gz
tar -xvf pandoc-2.16.2-linux-amd64.tar.gz
sudo mv pandoc-2.16.2-linux-amd64/bin/pandoc /usr/local/bin/pandoc