
function copy_ssh_key_to_clipboard() {
    key=$(cat ~/.ssh/id_rsa.pub)
    if [[ $OSTYPE == darwin* ]]; then
        pbcopy < <(echo "$key")
    else
        echo "$key" | xclip -selection clipboard
    fi
}

# Handy utility to time how long it takes to start up the shell
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timeshell() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

function update_dotfiles() {
    git fetch -q >> /dev/null 2>&1
    if (( $(git rev-list HEAD...origin/master --count) > 0 )); then
        printf "There are dotfiles updates available. Update? [Yn]: "
        read answer
        if [[ "$answer" == "n" ]] ; then
            echo "Update skipped. To update manually use command: update_dotfiles"
            return 1
        fi

        echo "Updating dotfiles"
        git fetch --quiet origin master
        git reset --hard FETCH_HEAD
        echo "Dotfiles have been updated"
    fi
}