#!/usr/bin/env bash

PLISTS=(
    "com.apple.Terminal.plist"
    "com.apple.finder.plist"
    "com.apple.dock.plist"
    "com.amethyst.Amethyst.plist"
    )

function copy_settings {
    # Copy Terminal plist locally for backup
    echo "Copying plists locally"
    for plist in "${PLISTS[@]}"; do
        echo "Copying $plist"
        cp ~/Library/Preferences/${plist} home/Library/Preferences/${plist}
    done

    echo "Copying Karabiner Elements settings"
    cp ~/.config/karabiner/karabiner.json home/.config/karabiner/karabiner.json

    echo "Copying tmux config"
    cp ~/.tmux.conf home/.tmux.conf
}

function deploy_settings {
    echo "Deploying plists"
    for plist in "${PLISTS[@]}"; do
        echo "Copying $plist"
        cp home/Library/Preferences/${plist} ~/Library/Preferences/${plist}
    done

    echo "Deploying tmux config"
    cp ./home/.tmux.conf ~/

    echo "Deploying karabiner config"
    mkdir -p ~/.config/karabiner
    cp ./home/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
}