#!/usr/bin/env sh

ln -s ~/dotfiles/home/.todo.cfg ~/.todo.cfg
ln -s ~/dotfiles/home/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/home/nvim ~/.config/
ln -s ~/dotfiles/home/yabai ~/.config/

mkdir -p ~/.config/alacritty/
ln -s ~/dotfiles/home/alacritty.yml ~/.config/alacritty/alacritty.yml
