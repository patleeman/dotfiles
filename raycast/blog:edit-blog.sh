#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Blog: Edit Files
# @raycast.mode compact

# Optional parameters:
# @raycast.packageName Blog
# @raycast.icon 📝

# Documentation:
# @raycast.description Execute command to edit blog
# @raycast.author Patrick Lee
# @raycast.authorURL https://patricklee.nyc


BLOG_PATH="$HOME/workingdir/patricklee.nyc"
code "$BLOG_PATH"


