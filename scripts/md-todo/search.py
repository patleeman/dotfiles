#!/usr/bin/env python3
import os
import subprocess
from pyfzf.pyfzf import FzfPrompt
from hashlib import md5
from enum import StrEnum


class Actions(StrEnum):
    DONE = "Mark as done"
    WONT_DO = "Mark as won't do"
    OPEN_VIM = "Open file in Neovim"


def parse_files(directory):
    checklist_items = []
    for root, dirs, files in os.walk(directory):
        # TODO: Add an ignore file
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                with open(file_path, "r") as f:
                    for line_num, line in enumerate(f):
                        if "[ ]" in line:
                            text = line.strip()
                            todo_index = text.index("[ ]") + 3
                            todo_item = text[todo_index:].strip()
                            payload = {
                                "path": file_path,
                                "raw": text,
                                "line": line_num + 1,
                                "todo": todo_item,
                                "hash": md5(todo_item.encode('utf8')).hexdigest()
                            }
                            checklist_items.append(payload)
    return checklist_items


if __name__ == "__main__":
    fzf = FzfPrompt()
    NOTES_DIR = "~/Dropbox/Notes"
    notes_path = os.path.expanduser(NOTES_DIR)
    todo_items = parse_files(notes_path)
    display = [
        f"{x['hash'][0:4]}: {x['todo']}" for x in todo_items]

    chosen_item = fzf.prompt(display)
    if not len(chosen_item) > 0:
        exit(0)

    id = chosen_item[0].split(":")[0]
    found_todo = None
    for todo in todo_items:
        if id in todo["hash"]:
            found_todo = todo

    action = fzf.prompt([Actions.OPEN_VIM, Actions.DONE,
                        Actions.WONT_DO])
    if not len(action) > 0:
        exit(0)

    action = action[0]
    if action == Actions.DONE:
        print('DONE')
    elif action == Actions.WONT_DO:
        print("Won't Do")
    elif action == Actions.OPEN_VIM:
        subprocess.call(['nvim', f'+{found_todo["line"]}', found_todo['path']])
        exit(0)
    elif action == Actions.EXIT:
        print("DO NOTHING")
