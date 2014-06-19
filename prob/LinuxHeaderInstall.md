Linux header 安装
============================

参考文章
-----------------------
http://www.2cto.com/os/201308/238749.html

用于解决问题
-----------------------
安装VMtool时候 What is the location of the directory of C header files that match your running
kernel? 提示需要安装Linux kernel header

问题解决方法
-------------------------
```shell
sudo apt-get update
sudo apt-get install build-essential linux-headers-$(uname -r)
```
第一行更新软件源
第二行 build-essential 安装编译需要的编译器
linux-headers-$(uname -r) 自动选择对应内核版本的header包。

