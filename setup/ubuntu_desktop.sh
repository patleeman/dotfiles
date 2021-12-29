# Additional setup for Ubuntu based desktop environments.
# Tested with Pop!_OS 20.10

echo "Installing flatpack"
sudo apt-get install -y flatpak

echo "Installing vscode"
flatpak install -y flathub com.visualstudio.code

echo "Installing firefox"
flatpak install -y flathub org.mozilla.firefox

echo "Installing Docker"
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing FiraCode Font"
sudo apt-get install -y fonts-firacode

echo "Installing xcopy xsel"
sudo apt-get install -y xclip xsel
