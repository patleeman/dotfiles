
if [[ ! $LOAD_FILE ]]; then
  echo "ERROR: LOAD_FILE not set"
  exit 1
fi

EXPORT_DOTFILES="export DOTFILES_DIR=\"$LOAD_FILE\""
LOAD_COMMAND="source \"$LOAD_FILE\""

if [[ -n "$ZSH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.zshrc; then
    echo -n $EXPORT_DOTFILES >> ~/.zshrc
    echo -n $LOAD_COMMAND >> ~/.zshrc
    echo "Installed load script in ~/.zshrc"

elif [[ -n "$BASH_VERSION" ]] && ! grep -Fq "$LOAD_COMMAND" ~/.bashrc; then
    echo -n $EXPORT_DOTFILES >> ~/.bashrc
    echo -n $LOAD_COMMAND >> ~/.bashrc
    echo "Installed load script in ~/.bashrc"

else
    echo "Load script not installed in ~/.zshrc nor ~/.bashrc. Please manually add the following lines to one of those files:"
    echo "  $EXPORT_DOTFILES"
    echo "  $LOAD_COMMAND"
fi