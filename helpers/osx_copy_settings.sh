#!/usr/bin/env bash

# Copy Terminal plist locally for backup
echo "Copying Terminal plist locally"
cp ~/Library/Preferences/com.apple.Terminal.plist home/Library/Preferences/com.apple.Terminal.plist

echo "Copying Karabiner Elements settings"
cp ~/.config/karabiner/karabiner.json home/.config/karabiner/karabiner.json

echo "Copying tmux config"
cp ~/.tmux.conf home/.tmux.conf