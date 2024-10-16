---
layout: blog
banana: true
category: cpp
title:  cmake && GDB的使用方法
date:   2023-07-30 16:52:28
background: green
tags:
- cpp
---

* content
{:toc}


### Cmake



#### cmake 教程

- 编写 CMakeLists.txt 文件。
- 创建一个 build 目录，用来存放 cmake 生成的文件。（这一步非必须）
- cd 进入 build 目录下，执行 cmake .. 命令，将 CMakeLists.txt 文件转化为 make 所需的 makefile 文件，其中路径 .. 表示 CMakeLists.txt 所在目录（路径可以根据自己 CMakeLists.txt 所在目录更改）。
- 在 build 目录下，执行 make 命令，生成目标可执行文件。（注意：make 命令要在 cmake 生成的 makefile 文件所在目录下执行，

我这里生成的 makefile 文件在 build 目录下。）



```bash
# src 下 有 CMakeLists.txt
# 需要进入 /src
cmake src/..
make
```





### GDB

#### gdb官方文档

[GDB Documentation (sourceware.org)](https://www.sourceware.org/gdb/documentation/)



#### gdb 调试过程

要使用 g++ 和 GDB 进行调试，请按照以下步骤操作：

1. **编译**代码：首先，使用 `g++` 命令来编译你的代码，并添加 `-g` 选项以生成带有调试符号的可执行文件。例如：

    ```
    g++ -g your_code.cpp -o your_program
    
    // 如果是使用cmake, 在 makelists.txt 加上这两句话
    set(CMAKE_BUILD_TYPE DEBUG)
    add_definitions(-g)
    ```

2. **启动 GDB**：在终端中输入 `gdb` 命令，然后在 GDB 提示符下启动你的程序，如下所示：

    ```
    gdb your_program
    ```

3. 设置断点：在 GDB 中，你可以使用 `break` 命令**设置断点**。例如，要在主函数的第 10 行设置断点，可以键入：

    ```bash
    break main.cpp:10
    ```

4. 运行程序：输入 `run` 命令来运行程序。当程序达到**断点**时，它会**停止执行**。

    ```
    run
    ```

5. 执行调试命令：一旦程序停止在断点处，你可以使用各种 GDB 命令来检查变量的值、单步执行代码等。

    - 使用 `next` 命令（简写为 `n`）逐行执行代码，而不进入函数调用。
    - 使用 `step` 命令（简写为 `s`）**进入函数调用**并逐行执行**函数内部**的代码。( 常用 )
    - 使用 `print` 命令（简写为 `p`）打印变量的值。
    - 使用 `continue` 命令（简写为 `c`）继续执行程序直到下一个断点。

    你还可以使用其他的 GDB 命令进行更高级的调试操作。

6. 退出 GDB：要退出 GDB，可以使用 `quit` 命令或按下 `Ctrl + D`。

以上是使用 g++ 和 GDB 进行调试的基本步骤。你可以根据具体需求和调试情况来使用其他 GDB 命令。



#### 常用命令

```bash
r：run，执行程序
n：next，下一步，不进入函数
s：step，下一步，会进入函数
b：breakponit，设置断点
l：list，查看源码
c：continue，继续执行到下一断点
bt：backtrace，查看当前调用栈
p：print，打印查看变量
print (variable)
q：quit，退出 GDB
whatis：查看对象类型
info threads：查看线程
info breakpoints (info b)：查看所有的断点
info locals：查看局部变量
info args：查看函数的参数值及要返回的变量值
info frame：堆栈帧信息


(1) 查看可切换调试的线程：info threads
(2) 切换调试的线程：thread 线程 id
(3) 只运行当前线程：set scheduler-locking on
(4) 运行全部的线程：set scheduler-locking off
(5) 指定某线程执行某 gdb 命令：thread apply 线程 id gdb_cmd
(6) 全部的线程执行某 gdb 命令：thread apply all gdb_cmd
```

