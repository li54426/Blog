---
layout: blog
category: API_software
title:  
date:   2024-04-08 21:44:44
background: blue
tags:
- API_software
---

* content
{:toc}


### 1 概述



[原作者地址](https://as.js.cool/demo/wps/)

文档地址：[https://as.js.cool](https://as.js.cool/)



#### 1.1 已经实现功能

- 云盘每日签到
-  公共号每日签到
-  公众号抽奖
-  每日任务 - 上传
-  ~~每日任务 - 云笔记~~（官方下线）
-  APP 抽奖（摇一摇）
-  浇水种树 - 云盘 APP
-  浇水种树 - 邮箱 APP
-  每月任务 - 邮箱 APP - 可直接完成的
-  热门任务 - 分享文件每月 7 次
-  邮箱 APP 开盲盒
-  每月任务 - PC 端登录
-  合成大芝麻每月 1 次
-  每月分享 20 次
-  每月上传 1 G
-  AI 猜字谜
-  自动领取每月备份奖励（APP / 邮箱）
-  更多每月任务适配中，敬请不要期待
- 





#### 需要的 信息

- 代码 ： [npmmirror 镜像站](https://npmmirror.com/package/@asunajs/dist/files/caiyun.wps.js?version=0.0.11#L44)

- gitee  [asuna: 介绍剧吐ʚ♡⃛ɞ(ू・ᴗ・ू❁) (gitee.com)](https://gitee.com/asunajs/asuna)

- 列表不需要额外的设计，直接**简单**粗暴，A 列是当前账号的手机号，B 列是之前复制的 authorization，C 列是之前复制的 auth_token（支持多账号，放多行）

    

| 参数1  | 参数2         | 参数3      |
| ------ | ------------- | ---------- |
| 手机号 | authorization | auth_token |
|        |               |            |











### 金山文档（WPS 云文档）使用详细教程

#### 1 准备工作

#### 1.1 创建账号

官网 [https://www.kdocs.cn/](https://www.kdocs.cn/)

如果你未曾拥有金山文档账号，请先注册一个账号，然后登录。详细步骤略。

1.2 创建文档

点击首页的 `+新建`

<img src="https://as.js.cool/_astro/create_docs.DhXuj-5F_Z8xdfF.webp" alt="创建文档" />

然后选择 `智能表格` 或者 `表格`（这里以表格为例）

然后创建一个空白表格

![创建一个空白表格](https://as.js.cool/_astro/create_table.my37e0GO_2ixFlA.webp)

#### 表格介绍

![表格介绍](https://as.js.cool/_astro/table_info.DxVdUbAt_I1qVf.webp)

字母 ABCD。。。 表示表格的列

数字 1234。。。 表示表格的行

`A1` 表示第一行第一列（左上角那个格子），那么 `B2` 呢？

最底部有个 `Sheet1` （中文叫做 单元格），新建的表格只有一个单元格，你可以点击后面的 `+` 添加（选择工具表）

鼠标左键双击 `Sheet1` 这个单元格名称，然后就能输入你想要的名称了，比如 `夸克网盘`。

鼠标左键单击 `Sheet1` 这个单元格，就是选中这个单元格（有多个单元格时有效，例如图中 `Sheet2` 绿色加粗的，所以我当前选择的是 `Sheet2`）。



试试让自己拥有 `alipan`，`quark` 以及 `推送` 三个单元格吧。成功后进入下一章节。



### 2 表格设计

表格设计是为了写入 网络传输所需要的`cookie`信息等

- 1 点击刚才创建的 `推送` 单元格

推送配置设计如下：

表格如图所示，每两列为一个配置单元（每个单元之间允许空列，可有可没有，例如 C 列就是空的，但是 EF 之间没有空）

单元的第首行首列放置推送名，如 email，pushplus。base 比较特殊。（如果没有放推送名，下面写的东西就会被忽略掉）

除第一行外，每个单元第一列为配置名称，第二列为值，中间允许空行（如 email 的第 4 行所示）

![推送](https://as.js.cool/_astro/create_push.Dh-VwnaQ_Z15dPWB.webp)

注意：图中表格的颜色是为了方便演示添加的，无实际意义，你不必和我的一样。



#### 运行简单的脚本

**以阿里云盘签到为例**

![表格介绍](https://as.js.cool/_astro/alpan_token.BycbK2Hr_T3ynL.webp)

选择 `alipan` 单元格，在 `A1` 填上你的 token（如何获取不在本教程范围内，请自行完成）。每一行表示一个用户，故 `A2` 可以是你的第二个账号，`A3` 呢？以此类推。。。





### 3 创建脚本

![创建脚本](https://as.js.cool/_astro/create_air.BVVMBIX0_Td4WM.webp)



![](assets/blog/202404082301604_airscript_jiaoben.png)

![](https://gitee.com/li54426/the_pictures/raw/master/img//202404082301604_airscript_jiaoben.png)

1.  点击头部菜单栏的 `效率`
2.  选择`高级开发`
3.  选择 `AirScript 脚本编辑器`
4.  点击文档共享脚本后面的 `+` 加号

![创建脚本](https://as.js.cool/_astro/create_air2.CoY1T7I3_ZVpdhM.webp)

5.  粘贴脚本代码（示例代码：[https://npmmirror.com/package/@asunajs/dist/files?version](https://npmmirror.com/package/@asunajs/dist/files?version) 点击后选择 `alipan.wps.js`）
6.  点击输入框上面的操作栏的第六个，一个六边形图标那个（鼠标放上去显示服务授权）
7.  点击添加服务
8.  添加 `网络API`，`邮箱API`

![运行](https://as.js.cool/_astro/create_air3.DRHFg6O7_ZQMj34.webp)

9.  点击输入框上面的操作栏的第四个，一个三角形图标那个（鼠标放上去显示运行 F5）
10.  允许服务授权

![成功](https://as.js.cool/_astro/create_air4.BhKaaVj__Zm7yK7.webp)

当看到成功提示时，恭喜你，你已经成功运行了脚本。



### 4 定时运行

这里就不放图了

![](assets/blog/202404082259555_airscript_dingshi.png)

![](https://gitee.com/li54426/the_pictures/raw/master/img//202404082259555_airscript_dingshi.png)





1.  点击头部菜单栏的 `效率`
2.  选择 `高级开发`
3.  选择 `定时任务`
4.  右边出来的抽屉中点击蓝色的 `创建任务`
5.  选择每天，再选个具体时间（不推荐晚上接近 12 点，也不推荐凌晨）
6.  选择你创建的脚本
7.  然后点击确定

恭喜你，你已经成功设置了定时任务。



### 5 附件

[移动云盘签到模板](assets/office/caiyun签到模板.xlsx)

[哔哩哔哩签到](assets/office/漫画签到-模板.xlsx)

