#!/usr/bin/env sh

ln -s ~/dotfiles/home/.todo.cfg ~/.todo.cfg
ln -s ~/dotfiles/home/.tmux.conf ~/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
. ~/.tmux/plugins/tpm/bin/install_plugins

