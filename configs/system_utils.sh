
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
