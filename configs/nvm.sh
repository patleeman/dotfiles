export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# https://stackoverflow.com/questions/23556330/run-nvm-use-automatically-every-time-theres-a-nvmrc-file-on-the-directory
load-node-version() {
    node_version=$(find .node-version -exec cat {} + 2> /dev/null);
    if [ -n "$node_version" ]; then
        nvm use "$node_version";
    fi;
}
load-node-version
