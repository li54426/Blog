#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
category: LLM
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-8-1/24280498.jpg
tags:
- langchain
- openai
- llm
---

* content
{:toc}
EOF

echo "文件已生成：$filename"
