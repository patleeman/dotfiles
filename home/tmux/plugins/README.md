# Tmux Plugins

I'm adding tmux plugins in this folder as git subtrees. Use the command from the base directory to add:

```bash
git subtree add --prefix home/tmux/plugins/ ssh://git-repo-url.git <branch> --squash
```

Then to update plugins:

```bash
git subtree pull --prefix home/tmux/plugins/ ssh://git-repo-url.git <branch> --squash

```
