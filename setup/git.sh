#!/usr/bin/env sh

git config --global user.name "Patrick Lee"
git config --global user.email "git@patricklee.nyc"

# Make Git not complain about pushing upstream branches.
git config --global push.default current
git config --global pull.rebase true
git config --global code.editor "code --wait"
git config --global diff.tool "vscode"
git config --global difftool.vscode.cmd 'code --wait --diff $REMOTE $LOCAL'
git config --global --add difftool.prompt false
git config --global merge.tool "vscode"
git config --global mergetool.vscode.cmd 'code --wait $MERGED'