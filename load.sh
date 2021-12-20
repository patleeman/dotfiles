#!/usr/bin/env bash

SCRIPT_DIR="$(find $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/configs)"
for DOTFILE in $SCRIPT_DIR
do
    if [ -f "$DOTFILE" ]; then
        source "$DOTFILE"
        echo "Loaded $DOTFILE"
    fi
done