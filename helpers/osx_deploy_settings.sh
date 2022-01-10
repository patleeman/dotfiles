
echo "Deploying Terminal settings"
cp home/Library/Preferences/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist

echo "Copying tmux config"
cp ./home/.tmux.conf ~/

echo "Copying karabiner config"
mkdir -p ~/.config/karabiner
cp ./home/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json