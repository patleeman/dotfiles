#!/usr/bin/env bash

export BLOG_PATH="$HOME/workingdir/patricklee.nyc"

function edit_blog() {
    if [ -d "$BLOG_PATH" ]; then
        code "$BLOG_PATH"
    else
        echo "Blog not found in $BLOG_PATH"
    fi
}

function blog() {
    if [ -d "$BLOG_PATH" ]; then
        "$BLOG_PATH/blog" "$@"
    else
        echo "Blog not found in $BLOG_PATH"
    fi
}
