
function copy_ssh_key_to_clipboard() {
    key=$(cat ~/.ssh/id_rsa.pub)
    if [[ $OSTYPE == darwin* ]]; then
        pbcopy < <(echo "$key")
    else
        echo "$key" | xclip -selection clipboard
    fi
}

function update_dotfiles() {
    if (( $(git rev-list HEAD...origin/master --count) > 0 )); then
        echo "There are dotfiles updates available. Update? [Yn]"
        read answer
        if [ "$answer" == "n"]; then
            echo "To update manually run update_dotfiles"
            return 1
        fi

        echo "Updating dotfiles"
        git fetch origin master
        # git reset --hard FETCH_HEAD
        echo "Updating dotfiles complete"
    fi
}