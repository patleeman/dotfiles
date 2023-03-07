#!/usr/bin/env sh

ln -s ~/dotfiles/home/.todo.cfg ~/.todo.cfg
ln -s ~/dotfiles/home/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/home/nvim/ ~/.config/

# Trigger packer sync to install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'