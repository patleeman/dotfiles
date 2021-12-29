
if [[ ! $LOAD_FILE ]]; then
  echo "ERROR: LOAD_FILE not set"
  exit 1
fi

LOAD_COMMAND="
export DOTFILES_DIR="$LOAD_FILE"
source $LOAD_FILE"

if [[ -n "$ZSH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.zshrc; then
    echo -n $LOAD_COMMAND >> ~/.zshrc
    echo "Installed load script in ~/.zshrc"
fi

if [[ -n "$BASH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.bashrc; then
    echo -n $LOAD_COMMAND >> ~/.bashrc
    echo "Installed load script in ~/.bashrc"
fi