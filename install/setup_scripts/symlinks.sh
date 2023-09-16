#!/usr/bin/env sh

ln -s ~/dotfiles/home/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/home/nvim ~/.config/
ln -s ~/dotfiles/home/yabai ~/.config/
ln -s ~/dotfiles/home/skhd ~/.config/

mkdir -p ~/.config/alacritty/
ln -s ~/dotfiles/home/alacritty.yml ~/.config/alacritty/alacritty.yml
