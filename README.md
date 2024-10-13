# Blog
存储博客的静态文件

如果换了新的电脑，只需要

1 下载并添加一个`hugo.exe`文件，并运行

```bash
hugo server -D
```

2 提交



## V4.0

使用`hugo`来重新组织github page 博客

已经完成

- 自动化部署
- 迁移工作
- 添加图标
- 添加个人头像
- 添加`Blog\content\page`下`links`等链接





已经完成以下迁移工作

- API software
- automation bash 
- byte tech
- cpp
- leetcode week 
- liblinux
- summary





### 图片问题

1. 所有博文的图片都放到的 `/static` 目录下，统一管理。 `/static` 可能不是必须存在，可以手动创建。此时的图片通过 `![](/sunset)` 的方式来访问，多了一条斜杠。 **Latex 论文里的图片就是这样管理的**，以前担心混乱， 实际上因为图片不多，命名规范也还好。
2. 网络图片加载不出来

在`md文件`中加入，注意，要加在正文中

```bash
<meta name="referrer" content="never">
```

