---
layout: blog
banana: true
category: API_software
title:  "如何基于github快速建立博客站点"
date:   2023-07-30 16:28:49
background: blue
tags:
- blog
- API_software
---

* content
{:toc}




## 修改

- 从原作者项目地址进行 `clone` [原作者项目地址在这里](https://github.com/Liberxue/liberxue.github.io)
- 进行修改
- 上传





#### 设置说明

- 修改_config.yml 的 links 为您的菜单
- 修改_config.yml 的 paginate 为您的按照多少页分页
- 修改自己的网**图标**`\style\favicons\favicon.ico`
- 修改自己的网**标志**`\style\favicons\logo-liberxue.png`
- 在`_layouts\blog.html`中, 将 `本文由 <a href="/">liberxue</a> 创作` 改为您的`github`名字
- 修改`\about.md`中的内容, 它对应着文章中的`关于`这一页
- 在`_layouts\default.html`中, 将 `本文由 <a href="/">liberxue</a> 创作` 改为您的`github`名字



#### 使用说明

- 打开`\_posts` 文件夹是**博客文章**所在的位置，文件夹中的内容就是你的**博客**, 博客格式为 `markdown`
- 文件名格式为`2015-06-11-xxxx.md`, **不能有中文**, 因为文件名会成为这篇博文的链接
- ~~当天的`blog`不会上传~~

```markdown
layout: blog
book: true
title:  "《美丽新世界》之幸福和自由思考"
background: green
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-7-15/78939382.jpg
date:   2017-07-03 23:13:54
category: 书籍
tags:
- 美丽新世界 





可选项目
// 设置颜色
background: green
background: blue
background: purple

// 设置路径
redirect_from:
  - /about/
```





#### 颜色说明

- 蓝色: 软件/ API/ 提升效率
- 绿色: 语言相关
- 紫色: 算法/ 周赛



