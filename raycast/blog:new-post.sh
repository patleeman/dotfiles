#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Blog: New Post
# @raycast.mode compact

# Optional parameters:
# @raycast.packageName Blog
# @raycast.icon 📝
# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": false}

# Documentation:
# @raycast.description Create a new Blog Post
# @raycast.author Patrick Lee
# @raycast.authorURL https://patricklee.nyc


BLOG_PATH="$HOME/workingdir/patricklee.nyc"
slugified=$(echo "${1}" | tr "[:upper:]" "[:lower:]" | tr -d '[:punct:]' | tr -s ' ' '_')
new_post="${BLOG_PATH}/blog/$(date '+%Y%m%d')_${slugified}.md"

cat << EOF > $new_post
---
layout: blog-post.liquid
title: "${1}"
description:
date: $(date '+%Y-%m-%d')
permalink: "blog/{{ title | slugify }}/index.html"
tags:
  - post
---

EOF

# code "$new_post"


