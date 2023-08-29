#!/usr/bin/env bash
if [ -z "$DOTFILES_DIR" ]; then
	echo "DOTFILES_DIR not set, please run this install from ~/dotfiles/install.sh"
	exit 1
fi

mkdir ~/workingdir

sudo apt install wget curl thefuck pandoc exa bat jq ripgrep tmux fzf fonts-firacode polybar

# i3wm from https://i3wm.org/docs/repositories.html
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3

# Neovim from source
sudo apt-get install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim ~/workingdir
cd ~/workingdir/neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Set up symlinks
ln -s ~/dotfiles/home/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config
ln -s ~/dotfiles/home/nvim ~/.config/
mkdir -p ~/.config/i3
ln -s ~/dotfiles/home/.config/i3/config ~/.config/i3/config
mkdir -p ~/.config/i3status
ln -s ~/dotfiles/home/.config/i3status/config ~/.config/i3status/config

# Set up manually installed scripts
. ~/dotfiles/install/setup_scripts/git.sh
. ~/dotfiles/install/setup_scripts/setup_load_script.sh

# Install rust
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"

# Alacritty
sudo apt install cmake pkg-config libfreetype7-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
git clone https://github.com/alacritty/alacritty.git ~/workingdir/alacritty
cd ~/workingdir/alacritty
cargo build --release
rustup override set stable
rustup update stable
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
echo "source $(pwd)/extra/completions/alacritty.bash" >>~/.bashrc

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
