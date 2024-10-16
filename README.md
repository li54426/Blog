# Blog
存储博客的静态文件

如果换了新的电脑，只需要

1 下载并添加一个`hugo.exe`文件，并运行

```bash
hugo server -D
```

2 提交



## 修改V4.0

使用`hugo`来重新组织github page 博客

尝试在 `1024code`中运行博客环境

#### 已经完成的工作

- 自动化部署
- 解决图床图片无法显示的问题，解决本地图片无法显示的问题
- `markdown`文件的迁移工作
- 添加网站图标、个人头像，以及站点描述
- 添加`\content\page\`下`links`等链接（主页左侧边栏）
- 每页显示的blog数量为10
- **重定义**网页`URL`的组织形式
- 



### 左侧侧边栏

- 不需要在`yaml`文件中修改，只需要在`/content/pages/`下面新建文件夹
- 新建了两个页面，`下载`和`好软`，分别用来提供`成型笔记的下载`以及`好软推荐的功能`



### 右侧侧边栏

- 去除`分类`这个选项



### 图片问题

1. 所有博文的图片都放到的 `/static` 目录下，统一管理。 `/static` 可能不是必须存在，可以手动创建。此时的图片通过 `![](/sunset)` 的方式来访问，多了一条斜杠。 **Latex 论文里的图片就是这样管理的**，以前担心混乱， 实际上因为图片不多，命名规范也还好。
2. 网络图片加载不出来

在`md文件`中加入，注意，要加在正文中

```bash
<meta name="referrer" content="never">
```



创建`layouts/partials/footer/custom.html`中加上

```html
<meta name="referrer" content="never">
```



#### 添加鼠标效果

- 【[particles.js 文档](https://github.com/VincentGarreau/particles.js)】
- 前往【[配置页面](http://vincentgarreau.com/particles.js/)】配置参数，参数按自己喜好即可，唯一注意要修改的参数是 **detect_on**，要改成 **window**
- 在 `layouts/partials/footer/custom.html` 中，引入以下代码

```html
<div id="particles-js"></div>

<script src={{ (resources.Get "background/particles.min.js").Permalink }}></script>
<script>
  particlesJS.load('particles-js', {{ (resources.Get "background/particlesjs-config.json").Permalink }}, function() {
    console.log('particles.js loaded - callback');
  });
</script>

<style>
  #particles-js {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: -1;
  }
</style>

```





```json
{
    "particles": {
        "number": {
            "value": 160,//数量
            "density": {
                "enable": true, //启用粒子的稀密程度
                "value_area": 800 //区域散布密度大小
            }
        },
        "color": {
            "value": "#ffffff" //原子的颜色
        },
        "shape": {
            "type": "circle", //原子的形状 "circle" ,"edge" ,"triangle" ,"polygon" ,"star" ,"image" ,["circle", "triangle", "image"]
            "stroke": {
                "width": 0, //原子的宽度
                "color": "#000000" //原子颜色
            },
            "polygon": {
                "nb_sides": 5 // 原子的多边形边数
            },
            "image": {
                "src": "img/github.svg", // 原子的图片可以使用自定义图片 "assets/img/yop.svg" , "http://mywebsite.com/assets/img/yop.png"
                "width": 100, //图片宽度
                "height": 100 //图片高度
            }
        },
        "opacity": {
            "value": 1, //不透明度
            "random": true, //随机不透明度
            "anim": {
                "enable": true, //渐变动画
                "speed": 1, // 渐变动画速度
                "opacity_min": 0, //渐变动画不透明度
                "sync": true 
            }
        },
        "size": {
            "value": 3, //原子大小
            "random": true, // 原子大小随机
            "anim": {
                "enable": false, // 原子渐变
                "speed": 4, //原子渐变速度
                "size_min": 0.3, 
                "sync": false
            }
        },
        "line_linked": {
            "enable": false, //连接线
            "distance": 150, //连接线距离
            "color": "#ffffff", //连接线颜色
            "opacity": 0.4, //连接线不透明度
            "width": 1 //连接线的宽度
        },
        "move": {
            "enable": true, //原子移动
            "speed": 1, //原子移动速度
            "direction": "none", //原子移动方向   "none" ,"top" ,"top-right" ,"right" ,"bottom-right" ,"bottom" ,"bottom-left" ,"left" ,"top-left"
            "random": true, //移动随机方向
            "straight": false, //直接移动
            "out_mode": "out", //是否移动出画布
            "bounce": false, //是否跳动移动
            "attract": { 
                "enable": false, // 原子之间吸引
                "rotateX": 600, //原子之间吸引X水平距离
                "rotateY": 600  //原子之间吸引Y水平距离
            }
        }
    },
    "interactivity": {
        "detect_on": "canvas", //原子之间互动检测 "canvas", "window"
        "events": {
            "onhover": {
                "enable": true, //悬停
                "mode": "bubble" //悬停模式      "grab"抓取临近的,"bubble"泡沫球效果,"repulse"击退效果,["grab", "bubble"]
            },
            "onclick": {
                "enable": false,  //点击效果
                "mode": "repulse"  //点击效果模式   "push" ,"remove" ,"bubble" ,"repulse" ,["push", "repulse"]
            },
            "resize": true // 互动事件调整
        },
        "modes": {
            "grab": {
                "distance": 100, //原子互动抓取距离
                "line_linked": { 
                    "opacity": 0.8  //原子互动抓取距离连线不透明度
                }
            },
            "bubble": {
                "distance": 250, //原子抓取泡沫效果之间的距离
                "size": 4, // 原子抓取泡沫效果之间的大小
                "duration": 2, //原子抓取泡沫效果之间的持续事件
                "opacity": 1, //原子抓取泡沫效果透明度
                "speed": 3 
            },
            "repulse": {
                "distance": 400, //击退效果距离
                "duration": 0.4 //击退效果持续事件
            },
            "push": {
                "particles_nb": 4 //粒子推出的数量
            },
            "remove": {
                "particles_nb": 2
            }
        }
    },
    "retina_detect": true
}
```







#### URL组织形式

在定义 URL 模式时使用这些令牌。前置数据中的 `date` 字段确定与时间相关的令牌的值。

- `:year`

    4 位数年份

- `:month`

    2 位数月份

- `:monthname`

    月份的名称

- `:day`

    2 位数日期

- `:weekday`

    1 位数星期几（星期日 = 0）

- `:weekdayname`

    星期的名称

- `:yearday`

    1 至 3 位数的年份中的天数

- `:section`

    数据所属的部分

- `:sections`

    数据的部分层次结构。您可以使用 *切片语法* 选择部分，例如 `:sections[1:]` 包括除了第一个以外的所有部分，`:sections[:last]` 包括除了最后一个以外的所有部分，`:sections[last]` 仅包括最后一个部分，`:sections[1:2]` 包括第 2 至第 3 部分。请注意，切片访问不会抛出任何越界错误，因此您不必非常准确。

- `:title`

    数据的标题

- `:slug`

    数据的 slug（如果在前置数据中未提供 slug，则使用标题）

- `:slugorfilename`

    数据的 slug（如果在前置数据中未提供 slug，则使用文件名）

- `:filename`

    数据的文件名（不含扩展名）









## 修改 V3 20240313



#### 主题修改

- [jekyll-theme-yat](https://github.com/jeffreytse/jekyll-theme-yat)
- 将即开即用
- 丢弃掉原本无用的文件，直接`fork`大佬的仓库
- 增加一个`software`的页面, 其中为常用的软件, 以及 软件的使用方法
- 增加一个`tools`页面, 







#### 全部命令

```yaml
layout: post
title: Welcome to Jekyll!
subtitle: A awesome static site generator.
author: Jeffrey
categories: jekyll
banner:
  video: https://vjs.zencdn.net/v/oceans.mp4
  loop: true
  volume: 0.8
  start_at: 8.5
  image: https://bit.ly/3xTmdUP
  opacity: 0.618
  background: "#000"
  height: "100vh"
  min_height: "38vh"
  heading_style: "font-size: 4.25em; font-weight: bold; text-decoration: underline"
  subheading_style: "color: gold"
tags: jekyll theme yat
top: 1
sidebar: []
```









#### 置顶文章

**数字越小，优先级越高。**

````
```
title: Your Article Title
top: 1
```

This is an example to show how to pin an article at top.
````





## 修改 V2-2023-7-31

- 因为上一个模板渲染代码块难以辨认, 使用了另一个模板[vszhub/not-pure-poole: A simple, beautiful, and powerful Jekyll theme for blogs. (github.com)](https://github.com/vszhub/not-pure-poole)













### md 生成网站 问题概览



#### 问题1 ---编译失败

最新的 2.0 版本似乎打破了 `\{\{` 在模板中的使用，不再类似以前的版本，在 2.0 版本使用 `\{\{` 会出现以下问题：

解决方案

- 两个 `\{\{`中间加`空格`=>`{ {`

```bash
'{ {' was not properly terminated with regexp: /\}\}/  (Liquid::SyntaxError)
```



#### 问题2---图片无法加载

- 不要在 \_posts 下面建立目录
- 新建一个文件夹`assets`

```mark
![image-20220906145334336](/assets/20230801md.png)
```



#### 问题 3 ---`about`无法使用

- `about`无法使用
- 解决方案
    - 在`about.md`中, 加入如下代码


```c++
---
permalink: /about/
---
```







### 设置(  模板修改 )  说明

- 在`_config.yml` 末尾 添加了, 每篇文章开启默认目录

```yaml
defaults:
  - values:
      toc: true
```

- 可以通过修改 _ config.yml 中的 `cover _ image `变量来设置自己的封面图像，还可以通过在每个页面上设置 `cover _ image` **变量**来设置不同页面上的封面图像。

- 产生路径方式(路由方式)`permalink: /:categories/:title.html`

- 您可以在`_data/social.yml` 中设置**社交链接**。您可以自定义标题，URL和图标（目前仅支持[字体真棒](https://fontawesome.com/)），例如：

    ```
    - title: Email
      url: mailto://vszhub@gmail.com
      icon: fas fa-envelope
    - title: Twitter
      url: https://twitter.com/vszhub
      icon: fab fa-twitter
    - title: GitHub
      url: https://github.com/vszhub/not-pure-poole
      icon: fab fa-github
    ```

- 将`about.md, tags.md, dates.md`移入`post`文件夹下并给他们加上时间， 没有时间的化默认不编译

- **侧边栏**增加新的导航`tools.md`, 来存放`github`的其他仓库，



### 分类导航

Not Pure Poole 支持按日期，类别和标签存档的帖子。要启用此功能，您应该将以下一些数据放入：`_data/archive.yml`

```
- type: dates
  title: Dates
  url: /dates/
- type: categories
  title: Categories
  url: /categories/
- type: tags
  title: Tags
  url: /tags/
```

之后，这些存档页面的导航将显示在主页顶部。

然后，您可以创建一个类别存档页面，并在该页面上设置以下参数：

```
---
layout: archive-taxonomies
type: categories
---
```

或标签存档页面：

```
layout: archive-taxonomies
type: tags
```

或按日期存档：

```
layout: archive-dates
```







### 增加功能

#### 命令

```yaml
layout: blog
book: true
title:  "你的标题"
date:   2017-07-03 23:13:54
category: 书籍
tags:
- 美丽新世界 
redirect_from:
  - /about/
```







#### 自动提交脚本

- 只是一个博客, 提交的信息就不重要了, 只提交一个 时间信息就好

```bash
@echo off

setlocal enabledelayedexpansion

REM 获取当前日期和时间
for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
    set year=%%l
    set month=%%j
    set day=%%k
)

for /f "tokens=1-3 delims=:." %%i in ("%time%") do (
    set hour=%%i
    set minute=%%j
    set second=%%k
)

REM 构建提交信息
set commit_message=%year%-%month%-%day% %hour%:%minute%:%second%

REM 添加文件到暂存区
git add .

REM 提交代码，并包含日期和时间作为提交信息
git commit -m "%commit_message%"

REM 推送到远程仓库
git push

endlocal

```



#### 自动生成 markdown

```markdown
#!/bin/bash

filename=$(date +"%Y-%m-%d-.md")

cat > "$filename" << EOF
---
layout: blog
banana: true
category: default
title:  
date:   $(date +"%Y-%m-%d %H:%M:%S")
background: green
tags:
- default
- memcache
---

* content
{:toc}
EOF

echo "文件已生成：$filename"

```







## 修改 V1-2023-7-29

[我的项目地址](https://li54426.github.io/)



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





原作者邮箱

```bash
liberxue@gmail.com
```















