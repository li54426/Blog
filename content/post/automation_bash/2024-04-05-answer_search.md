---
layout: post
category: bash_automation
title:  答案查找
date:   2024-04-05 17:05:44
tags:
- automation
- bash
banner:
 image: https://bit.ly/3xTmdUP
---

* content
{:toc}










#### 1 自动查找答案

在我们的生活中有这样的场景，需要做一些题目，而这些题目是知道答案的（例如，校规校纪，防火检查等）



代码的功能为: 读取问题、查询题库并生成查询结果的 Python 脚本。这个脚本可以处理文本预处理、从文本中提取题目、读取题库、进行查询并将结果保存到 Excel 文件等多个功能。

```python
import re
import pandas as pd



##########-读取查询列-#########


# 文本预处理

filepath = "./auto/question.txt"

with open(filepath, 'r', encoding='utf-8') as f:
    text = f.read()

text_new = text.replace('（', '(')
text_new = text_new.replace('）', ')')

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(text_new)




# 打开txt文件并读取内容
with open("./auto/question.txt", "r", encoding="utf-8") as file:
    content = file.read()
# print("contect=", content)

# 把题目导出来
pattern = r'(\d+\.+)(.+?)(?=(\(|\。|\n|$))'
matches = re.findall(pattern, content, flags=re.DOTALL)
# [('1. ', '质量流量计不能够直接测出的参数是（ ）'),.....]

# print("maches=", matches)

matches = [(ma[0], ma[1] ) for ma in matches]
print("maches=", matches)


# 将数据转换成 DataFrame 格式

# 将数据转换成 DataFrame 格式, 并修改列名为 "序号" 和 "答案"
df = pd.DataFrame(matches, columns=['序号', '问题'])

# 使用 slice() 方法将 content 列的字符串长度截断为 20
df['问题'] = df['问题']#.str.slice(20)



# print("df=", df)
# 将数据保存到 Excel 文件中
df.to_excel('./auto/问题列表.xlsx', index=False)






######### 读取题库 ##############
dic = []
# 读取单选题
df= pd.read_excel("./auto/diction.xlsx", sheet_name="one", usecols=[0,1])
value_array = df[["题目", "答案"]].values
#print(df)
dic1= [(question, ans) for question, ans in value_array]
dic.extend(dic1)


# 读取多选题
df= pd.read_excel("./auto/diction.xlsx", sheet_name="two", usecols=[0,1])
value_array = df[["题目", "答案"]].values
dic1= [(question, ans) for question, ans in value_array]
dic.extend(dic1)

# 读取判断题
df= pd.read_excel("./auto/diction.xlsx", sheet_name="bool", usecols=[0,1])
value_array = df[["题目", "答案"]].values
dic1= [(question, ans) for question, ans in value_array]
dic.extend(dic1)


# dic = [('修改后的《安全生产法》由习近平主席于2014年签署第十三号令予以公布，自2014年（）起施行。', 'C'),(),,,,]
# print("\n\n\ndic=", dic)


########### 进行查询 ###############
res= []

num = 0

for match in matches:
    # 查询id, 查询题目
    id = match[0]
    qu = match[1]
    
    # 题目过短, 自己进行处理
    if(len(qu)<=5):
        res.append((id, "没有答案"))
        continue
    
    flag = 0
    # 开始从题库中查询
    for allqu, ans in dic:
        if qu in allqu:
            res.append((id, ans))
            flag =1
            num+=1
            break
        
    
    if(flag ==0):
        res.append((id, "没有答案"))

# print("res=", res)
print("共查询到", num , "/", len(res),"个结果")

# 输出为 execl, 一共两列
data = {
    '题号': [item[0] for item in res],
    '答案': [item[1] for item in res]
}
df=pd.DataFrame(data)
df.to_excel("./auto/查询结果.xlsx",sheet_name="Sheet1", header=None, index=False)



############ 如果没有搜索到答案 ###########
print("下面请输入没有搜索到答案的问题")
for i in range(100):
    s = input("请输入问题：(右键即黏贴)\n")

    for ques, ans in dic:
        if s in ques:
            print(ans,"\n\n\n")
```





```python
import re
import pandas as pd

# 文本预处理
filepath = "./auto/question.txt"
with open(filepath, 'r', encoding='utf-8') as f:
    text = f.read()

text_new = text.replace('（', '(')
text_new = text_new.replace('）', ')')

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(text_new)

# 打开txt文件并读取内容
with open("./auto/question.txt", "r", encoding="utf-8") as file:
    content = file.read()

# 把题目导出来
pattern = r'(\d+\.+)(.+?)(?=(\(|\。|\n|$))'
matches = re.findall(pattern, content, flags=re.DOTALL)

matches = [(ma[0], ma[1]) for ma in matches]
print("matches=", matches)

# 将数据转换成 DataFrame 格式
df = pd.DataFrame(matches, columns=['序号', '问题'])
# 使用 slice() 方法将 content 列的字符串长度截断为 20
df['问题'] = df['问题']  # .str.slice(20)
# 将数据保存到 Excel 文件中
df.to_excel('./auto/问题列表.xlsx', index=False)

# 读取题库
dic = []
excel_file = pd.ExcelFile("./auto/diction.xlsx")
# 读取所有表格的数据
for sheet_name in excel_file.sheet_names:
    df = pd.read_excel(excel_file, sheet_name=sheet_name, usecols=[0, 1])
    value_array = df[["题目", "答案"]].values
    dic1 = [(question, ans) for question, ans in value_array]
    dic.extend(dic1)

# 进行查询
res = []
num = 0

for match in matches:
    # 查询id, 查询题目
    id = match[0]
    qu = match[1]

    # 题目过短, 自己进行处理
    if len(qu) <= 5:
        res.append((id, "没有答案"))
        continue

    flag = 0
    # 开始从题库中查询
    for allqu, ans in dic:
        if qu in allqu:
            res.append((id, ans))
            flag = 1
            num += 1
            break

    if flag == 0:
        res.append((id, "没有答案"))

print("共查询到", num, "/", len(res), "个结果")

# 输出为 execl, 一共两列
data = {
    '题号': [item[0] for item in res],
    '答案': [item[1] for item in res]
}
df = pd.DataFrame(data)
df.to_excel("./auto/查询结果.xlsx", sheet_name="Sheet1", header=None, index=False)

# 如果没有搜索到答案
print("下面请输入没有搜索到答案的问题")
for i in range(100):
    s = input("请输入问题：(右键即黏贴)\n")

    for ques, ans in dic:
        if s in ques:
            print(ans, "\n\n\n")

```









#### 2 子文件夹内容移出并重命名为子文件夹名称



```bash
@echo off
setlocal enabledelayedexpansion

rem 遍历当前文件夹下的每个子文件夹
for /d %%F in (*) do (
    set "folder_name=%%~nxF"
    
    rem 将子文件夹下的文件重命名为文件夹名字
    for %%G in ("%%~F\*") do (
        move "%%~G" "%%~dpF\!folder_name!_%%~nxG"
    )
    
    rem 将子文件夹下的所有文件移动到当前文件夹下
    move "%%~F\*" .
    
    rem 删除空的子文件夹
    rd "%%~F"
)
```





#### 3 生成目录树

`tree` 命令用于在命令行界面显示目录结构树，它会递归地列出指定目录及其子目录中的所有文件和文件夹，并以树状结构进行展示。这个命令通常在命令行界面中使用，对于需要快速了解目录结构的情况非常有用。

使用 `tree` 命令，你可以快速了解指定目录中的文件和文件夹的组织结构，包括子目录、文件名、文件大小等信息，从而更方便地进行文件管理和导航。

常见用法示例：

- `tree`: 显示当前目录下的目录结构树。
- `tree /F`: 显示目录结构树时，包括文件名。
- `tree /A`: 显示所有文件和文件夹，包括隐藏文件和系统文件。
- `tree /L n`: 限制目录层级，只显示前 n 层的目录结构。
- `tree /A /F > tree.txt`: 将目录结构树输出到文本文件 `tree.txt` 中。

总的来说，`tree` 命令是一个方便的工具，用于在命令行界面快速查看和分析目录结构。





```bash
tree >tree.txt
```

> D:.
> │  shilei_mymuduo.zip
> │  tree.txt
> │  __.DS_Store
> │  推荐课程学习路径.pdf
> │  目录树.bat
> │  重写muduo库.pdf
> │  
> └─视频
>      01项目介绍_ev.mp4
>      02.1_IO的阻塞和非阻塞_ev.mp4
>      02.2_IO的阻塞和非阻塞_勘误_ev.mp4
>      03 IO的同步和异步_IO的同步和异步_ev.mp4
>      04 阻塞&amp;非阻塞&amp;同步&amp;异步总结_阻塞&amp;非阻塞&amp;同步&amp;异步总结_ev.mp4
>      05 Linux的五种IO模型简介_Linux的五种IO模型简介_ev.mp4
>      06 Linux的五种IO模型详解_Linux的五种IO模型详解_ev.mp4
>      07 良好的网络服务器该怎么设计_良好的网络服务器该怎么设计_ev.mp4
>      08 Reactor模型详解_Reactor模型详解_ev.mp4



```bash
DIR /S > dirs.txt
```

> D:\正在看的视频\cpp_手写C++ Muduo网络库项目-掌握高性能网络库实现原理 的目录
>
> 2023/07/17  16:44    <DIR>          .
> 2023/07/17  16:44    <DIR>          ..
> 2023/07/17  16:44                 0 dirs.txt
> 2023/07/15  15:10             4,224 shilei_mymuduo.zip
> 2023/07/17  16:39             3,464 tree.txt
> 2023/07/15  15:10             4,096 __.DS_Store
> 2023/07/15  15:10            97,797 推荐课程学习路径.pdf
> 2023/07/17  16:44                17 目录树.bat
>
> 2023/07/15  16:20               466 子文件夹内容移出并重命名为子文件夹名称.bat
>            55 个文件  3,519,689,412 字节
>
>   所列文件总数:
>            62 个文件  3,520,852,047 字节
>             5 个目录 53,564,571,648 可用字节



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











请帮我生成批处理代码，实现以下功能，将当前目录下的子文件夹中的 png 文件 复制到，当前目录的上一级的 assets 文件夹下子文件夹blog 文件夹下





请帮我生成批处理代码，实现以下功能，将当前目录下的子文件夹中的 md 文件中的 “assets/” 修改为 “/assets/blog/”
