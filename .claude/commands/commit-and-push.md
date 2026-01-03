---
allowed-tools: Bash, Read, Edit, Glob, Grep
description: Review code, fix issues, commit with descriptive message, and push
---

## Commit and Push

Review all changes, fix any issues, then commit and push.

### Current State

- **Branch**: !`git branch --show-current`
- **Remote tracking**: !`git status -sb | head -1`
- **Staged changes**: !`git diff --cached --stat`
- **Unstaged changes**: !`git diff --stat`
- **Untracked files**: !`git ls-files --others --exclude-standard`

### Your Task

1. **Review the code changes**: Look at the diff carefully for any issues:
   - Syntax errors
   - Obvious bugs
   - Missing imports
   - Broken logic
   - Security issues
   - Leftover debug code (console.log, print statements, etc.)

2. **Fix any problems found**: If you find issues, fix them before committing.

3. **Stage all changes**: Stage all relevant files (but skip files that look like secrets: .env, credentials, keys, etc.)

4. **Create a descriptive commit message**:
   - Summarize what changed and why
   - Use conventional commit style if the repo uses it
   - Keep the first line under 72 characters
   - Add details in the body if needed

5. **Push to remote**: Push the changes to the current branch's upstream.

If push fails due to remote changes, inform the user and ask how to proceed (pull first, force push, etc.)
