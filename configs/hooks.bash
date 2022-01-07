#!/usr/bin/env bash

# Hooks for Bash
eval "$(direnv hook bash)"
eval $(thefuck --alias)

# Bash completion
# shellcheck source=/dev/null
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

