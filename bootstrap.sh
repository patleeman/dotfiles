#!/usr/bin/env bash

# Bootstrap script to enable quick setup on a new machine
# This script should be run with /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/patleeman/dotfiles/master/bootstrap.sh)"

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
		ssh-add --apple-use-keychain ~/.ssh/github_ed25519
		SSH_PUB=$(cat "$HOME/.ssh/github_ed25519.pub")
	fi

	# TODO: Make this cross platform compatible
	printf "%s" "$SSH_PUB" | pbcopy

	python -m webbrowser "https://github.com/settings/ssh/new"
	read -n 1 -p "SSH public key copied to clipboard, please add it to Github and then hit Enter to continue."
}

ssh -T git@github.com &>/dev/null
if [ "$?" == "255" ]; then
	echo "SSH key not set up, generating new ssh key."
	setup_ssh_key
fi

echo "Cloning dotfiles repo to ~/dotfiles/"
git clone git@github.com:patleeman/dotfiles.git ~/dotfiles/
echo "Launching install script"
. ~/dotfiles/install.sh
