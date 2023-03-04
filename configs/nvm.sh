#!/usr/bin/env sh

# https://gist.github.com/fl0w/07ce79bd44788f647deab307c94d6922
export NVM_DIR="$HOME/.config/nvm"

# Lazy load
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  NODE_GLOBALS=(`find $NVM_DIR/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
  NODE_GLOBALS+=("node")
  NODE_GLOBALS+=("nvm")
  NODE_GLOBALS+=("npx")
  # Lazy-loading nvm + npm on node globals
  load_nvm () {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  }
  # Making node global trigger the lazy loading
  for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
  done
fi
