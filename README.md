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



创建`layouts/partials/footer/custom.html`中加上

```html
<meta name="referrer" content="never">
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
