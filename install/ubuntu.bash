#!/usr/bin/env bash
if [ -z "$DOTFILES_DIR" ]; then
	echo "DOTFILES_DIR not set, please run this install from ~/dotfiles/install.sh"
	exit 1
fi

mkdir ~/workingdir

sudo apt install wget curl thefuck pandoc bat jq ripgrep tmux fzf fonts-firacode polybar

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# Install rust tools
cargo install eza

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

# Setup dotfiles
touch ~/.bashrc
LOAD_COMMAND=$(
	cat <<EOF
		
# load dotfiles
export DOTFILES_DIR="$DOTFILES_DIR"
. "$DOTFILES_DIR/load-ubuntu.sh"
EOF
)
echo "$LOAD_COMMAND" >>~/.bashrc
echo "Installed load script in ~/.bashrc"

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
