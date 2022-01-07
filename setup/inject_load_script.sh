DOTFILES_DIR="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
LOAD_FILE="${DOTFILES_DIR}load.sh"

if [[ ! $LOAD_FILE ]]; then
  echo "ERROR: LOAD_FILE not set"
  exit 1
fi

if [[ ! $DOTFILES_DIR ]]; then
  echo "ERROR: DOTFILES_DIR not set"
  exit 1
fi

LOAD_COMMAND=$(cat <<EOF

# Load dotfiles
export DOTFILES_DIR="$DOTFILES_DIR"
source "$LOAD_FILE"
EOF
)

if command -v zsh --version &> /dev/null ; then
    cp ~/.zshrc ~/.zshrc.bak
    echo -n "$LOAD_COMMAND" > ~/.zshrc
    echo "Installed load script in ~/.zshrc"
fi

if command -v bash --version &> /dev/null ; then
    cp ~/.bashrc ~/.bashrc.bak
    echo -n "$LOAD_COMMAND" > ~/.bashrc
    echo "Installed load script in ~/.bashrc"
fi
