
function copy_ssh_key_to_clipboard() {
    key=$(cat ~/.ssh/id_rsa.pub)
    if [[ $OSTYPE == darwin* ]]; then
        pbcopy < <(echo "$key")
    else
        echo "$key" | xclip -selection clipboard
    fi
}
