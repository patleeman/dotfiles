#!/bin/sh
# Add some helper text to common commands so I remember to use other cli tools.

man () {
    printf "Suggestion: Try using tldr for some examples!\n"
    command man "$@"
}

