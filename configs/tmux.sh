#!/usr/bin/env sh

# Set up nvim-tmux navigator
if [ -n "$TMUX" ]; then
	eval "$(tmux show-environment -s NVIM_LISTEN_ADDRESS 2>/dev/null)"
else
	export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
fi
