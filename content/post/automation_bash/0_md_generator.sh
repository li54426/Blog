#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: post
category: bash_automation
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
tags:
- automation
- bash
banner:
 image: https://bit.ly/3xTmdUP
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
