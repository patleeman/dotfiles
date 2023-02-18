#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Obsidian: Quick Task
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ☑️
# @raycast.packageName Obsidian
# @raycast.argument1 { "type": "text", "placeholder": "Task", "percentEncoded": false}
# @raycast.argument2 { "type": "text", "placeholder": "Tag", "optional": true , "percentEncoded": false}

# Documentation:
# @raycast.author Patrick Lee
# @raycast.authorURL https://patricklee.nyc

DATA="- [ ] ${1}"
if [ -n "${2}" ]; then
    DATA+=" #${2}"
fi

encoded_data=$(printf %s "$DATA"|jq -sRr @uri)
open "obsidian://advanced-uri/?daily=true&mode=append&data=${encoded_data}"