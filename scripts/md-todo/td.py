#!/usr/bin/env python3

import os
import subprocess
from pyfzf.pyfzf import FzfPrompt
from hashlib import md5
from enum import StrEnum
from dataclasses import dataclass
from datetime import datetime


NOTES_DIR = "~/Dropbox/Notes"


class Actions(StrEnum):
    DONE = "Mark as done"
    WONT_DO = "Mark as won't do"
    OPEN_VIM = "Open file in Neovim"


class TodoStates(StrEnum):
    OPEN = "[ ]"
    DONE = "[x]"
    WONT_DO = "[-]"


@dataclass
class TodoItem:
    path: str
    raw: str
    line: int
    todo: str
    hash: str
    short_hash: str


def parse_files(directory):
    checklist_items: list[TodoItem] = []
    for root, _, files in os.walk(directory):
        # TODO: Add an ignore file
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                with open(file_path, "r") as f:
                    for line_num, line in enumerate(f):
                        if TodoStates.OPEN in line:
                            text = line.strip()
                            todo_index = text.index(TodoStates.OPEN) + 3
                            todo_item = text[todo_index:].strip()
                            hash = md5(todo_item.encode('utf8')).hexdigest()
                            payload = TodoItem(
                                file_path,
                                line,
                                line_num + 1,
                                todo_item,
                                hash,
                                hash[0:4]
                            )
                            checklist_items.append(payload)
    return checklist_items


def mark_todo(todo: TodoItem, state: TodoStates, append: str = ""):
    with open(todo.path, 'r') as f:
        lines = f.readlines()

    line_to_modify = lines[todo.line - 1]
    if not line_to_modify == todo.raw:
        print("in-file: ", line_to_modify)
        print("expected: ", todo.raw)
        print("The file was modified! Not writing")
        exit(1)

    line_to_modify = line_to_modify.replace(TodoStates.OPEN, state)
    if append:
        line_to_modify = f"{line_to_modify} {append}"
    lines[todo.line - 1] = line_to_modify

    with open(todo.path, 'w') as f:
        f.writelines(lines)


def prompt():
    fzf = FzfPrompt()
    notes_path = os.path.expanduser(NOTES_DIR)
    todo_items: list[TodoItem] = parse_files(notes_path)

    fzf_display_strings = [
        f"{x.short_hash}: {x.todo}" for x in todo_items]

    chosen_todo = fzf.prompt(fzf_display_strings)
    if not len(chosen_todo) > 0:
        exit(0)

    id = chosen_todo[0].split(":")[0]
    todo_to_update: TodoItem | None = None
    for todo_item in todo_items:
        if id == todo_item.short_hash:
            todo_to_update = todo_item

    if todo_to_update is None:
        exit(1)

    action = fzf.prompt([Actions.OPEN_VIM, Actions.DONE,
                        Actions.WONT_DO])
    if not len(action) > 0:
        exit(0)

    action = action[0]
    date = datetime.now().strftime("%Y-%m-%d")
    if action == Actions.DONE:
        mark_todo(todo_to_update, TodoStates.DONE, f"done::{date}")
        print(
            f"Line {todo_to_update.line} in {todo_to_update.path} marked as done")
    elif action == Actions.WONT_DO:
        mark_todo(todo_to_update, TodoStates.WONT_DO, f"wontdo::{date}")
        print(
            f"Line {todo_to_update.line} in {todo_to_update.path} marked as won't do")
    elif action == Actions.OPEN_VIM:
        subprocess.call(
            ['nvim', f'+{todo_to_update.line}', todo_to_update.path])
        exit(0)


if __name__ == "__main__":
    prompt()
