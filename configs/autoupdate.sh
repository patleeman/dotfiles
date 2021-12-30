#!/usr/bin/env bash

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

# https://github.com/jez/dotfiles/blob/master/util/auto-update.sh
function check_for_updates() {
    update_threshold=86400
    last_update_file="$DOTFILES_DIR/.last_update"
    [ ! -e $last_update_file ] && touch $last_update_file
    last_check_ts=$(cat $last_update_file)
    last_check=$(date -r "$last_check_ts" +%s)
    time_now=$(date +%s)
    time_since_check=$((time_now - last_check))
    if [[ "$time_since_check" -ge "$update_threshold" ]]; then
        echo "Checking for updates to dotfiles..."
        update_dotfiles
        echo "$time_now" > $last_update_file
     fi
}

check_for_updates