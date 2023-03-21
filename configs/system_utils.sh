#!/usr/bin/env bash

# Small utility to list out the available ssh pub keys and copy it to your clipboard.
function copy_ssh_key_to_clipboard() {
	echo "Select the file you'd like to copy."
	PS3="Select ssh public key to copy, or 0 to exit: "
	files=("$HOME"/.ssh/*.pub)
	select file in "${files[@]}"; do
		if [[ $REPLY == "0" ]]; then
			break
		fi
		if [[ -n "$file" ]]; then
			key=$(cat "$file")
			if [[ $OSTYPE == darwin* ]]; then
				pbcopy < <(echo "$key")
			else
				# Else assumes you're on a linux system that supports xclip
				echo "$key" | xclip -selection clipboard
			fi
			echo "$file copied to system clipboard."
			break
		fi
	done
}

# Handy utility to time how long it takes to start up the shell
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timeshell() {
	shell=${1-$SHELL}
	for _ in $(seq 1 10); do /usr/bin/time "$shell" -i -c exit; done
}

# Get the local ip address
function get_local_ip_address() {
	ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}'
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}
