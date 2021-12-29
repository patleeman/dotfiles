# Minimal setup for headless environment.
# Tested with GH codespaces

sudo apt-get update
if [[ ! "$CODESPACES" == "true" ]]; then
    # 12/29/2021: Running upgrade freezes on azure-cli install.
    sudo apt-get -y upgrade
else
    echo "Skipping apt-get upgrade due to codespaces environment"
fi

sudo apt-get install -y curl wget

echo "Install thefuck utility"
sudo apt-get install -y thefuck

echo "Installing nvm & nodejs"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts
nvm use --lts

echo "Installing pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo "Installing direnv"
sudo apt-get install -y direnv

echo "Installing awscli"
sudo apt-get install -y awscli

echo "Installing Bash-it"
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

echo "Installing bash-completion"
sudo apt-get install -y bash-completion

echo "Installing Pandoc 2.16.2"
mkdir tmp
cd tmp
curl -LO https://github.com/jgm/pandoc/releases/download/2.16.2/pandoc-2.16.2-linux-amd64.tar.gz
tar -xvf pandoc*.tar.gz
sudo mv pandoc*/bin/pandoc /usr/local/bin/pandoc
cd ..
rm -rf tmp