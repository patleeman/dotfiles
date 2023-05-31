#/usr/bin/env bash

# Bootstrap script to enable quick setup on a new machine
# This script should be run with /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/patleeman/dotfiles/HEAD/bootstrap.sh)"

function setup_ssh_key {
	# Check for a SSH key and generate one if it doesn't exist.
	SSH_DIR="$HOME/.ssh"
	PUB_FILES=(id_ed25519.pub id_rsa.pub id_ecdsa.pub)
	for file in "${PUB_FILES[@]}"; do
		if [ -f "$SSH_DIR/file" ]; then
			SSH_PUB=$(cat "$HOME/.ssh/id_ed25519.pub")
			break
		fi
	done

	if [ -z "$SSH_PUB" ]; then
		echo "SSH Key doesn't exist, generating a new one"
		ssh-keygen -t ed25519 -f ~/.ssh/github_ed25519 -q -N ""
		SSH_PUB=$(cat "$HOME/.ssh/github_ed25519.pub")
	fi

	python -m webbrowser "https://github.com/settings/ssh/new"
}

# Clone down the
git clone git@github.com:patleeman/dotfiles.git ~/dotfiles/
. ~/dotfiles/install.sh
