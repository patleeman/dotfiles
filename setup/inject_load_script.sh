
if [[ ! $LOAD_FILE ]]; then
  echo "ERROR: LOAD_FILE not set"
  exit 1
fi

LOAD_COMMAND=$(cat <<EOF
# Load dotfiles
export DOTFILES_DIR="$LOAD_FILE"
source "$LOAD_FILE"
EOF
)

CHECK_COMMAND="source "$LOAD_FILE""

if [[ -n "$ZSH_VERSION" ]] && ! grep -Fq "$CHECK_COMMAND" ~/.zshrc; then
    echo -n "$LOAD_COMMAND" >> ~/.zshrc
    echo "Installed load script in ~/.zshrc"

elif [[ -n "$BASH_VERSION" ]] && ! grep -Fq "$CHECK_COMMAND" ~/.bashrc; then
    echo -n "$LOAD_COMMAND" >> ~/.bashrc
    echo "Installed load script in ~/.bashrc"

else
    echo -n "Load script not installed in ~/.zshrc nor ~/.bashrc. Please manually add the following lines to one of those files:"
    printf "\n$LOAD_COMMAND\n"
fi