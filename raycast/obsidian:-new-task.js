#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Obsidian: Quick Task
// @raycast.mode compact

// Optional parameters:
// @raycast.icon ☑️
// @raycast.packageName Obsidian
// @raycast.argument1 { "type": "text", "placeholder": "Task", "percentEncoded": false}
// @raycast.argument2 { "type": "text", "placeholder": "Tag", "optional": true , "percentEncoded": false}

// Documentation:
// @raycast.author Patrick Lee
// @raycast.authorURL https://patricklee.nyc

const process = require("process");
const { exec } = require("child_process");

const NOTE_NAME = "!Task Inbox";

const tag = process.argv[3].startsWith("#")
  ? process.argv[3]
  : `#${process.argv[3]}`;
const task = process.argv[2];
const content = `- [ ] ${task} ${tag}\n`;

const URI = `obsidian://new/?append=true&name=${encodeURIComponent(
  NOTE_NAME
)}&content=${encodeURIComponent(content)}`;

exec(`open "${URI}"`);
