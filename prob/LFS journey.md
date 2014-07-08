# 2014年7月2日开始了我的LFS编译之旅
原来作者就是喜欢都吧东西拼成一起来做。
另外这玩儿也挺有兴趣虽然没有对Linux做任何定制但是但是对理解Linux是非常有用的 。
所以做了LFS这个项目

#2014年7月3日

## package: BC
This package provides an arbitrary precision numeric processing language. It satisfies a requirement needed when
building the Linux kernel.
我已经看到各种包包的介绍了。
我感觉这个还是蛮有意思的。而且还是任意精度的 计算
而且还是Linux的内核，这个好啊

## 浏览第一遍。
其实这本书就是告诉你各种前期准备然后各种软件包的编译方法而已。
特么的前期准备还是比较简单的。
就是编译的时间肯定很长，貌似还是要3个小时左右吧。没有求解器长！

## 之后的计划
我肯定是不会去做那种仔细看书的了。
我已经了解书中的架构什么的
根据自己的理解来

## 开始实践
### 分区
```bash
#我是通过虚拟机搞的。我添加了一块硬盘。之后dev标号为sdb
fdisk /dev/sdb
n #添加新分区一路回车包括硬盘号码大小什么的都是正常的最后结果为sdb1 整块大小 primary分区 
w #将改变写入分区
#退出程序之后
mkfs -t ext4 /dev/sdb1 #分区之后格式化就行了
```

###部署空间
```bash
#写入bashrc：
export LFS=/mnt/lfs

mkdir /mnt/lfs/tools
ln -sv $LFS/tools /

mkdir /mnt/lfs/sources
ln -sv $LFS/sources /
```

### 添加用户
```bash

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs #这些基础的东西我就不解释了
#添加到.bashrc
PS1='[\[\e[32m\]#\##\[\e[31m\]\u@\[\e[36m\]\h \w]\$\[\e[m\]'  #这是我的习惯哈哈。我就喜欢这样
stty stop ''
export LFS=/mnt/lfs

#给权限准备开始工作了
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources

export MAKEFLAGS='-j 4'我是4核心处理器。所以就这么搞了。
```
### 小结
这部分还是挺简单，准备磁盘用户还有环境啊工作空间什么的。之后马上就要开始编译了。好紧张啊

### binutil
没问题
### GCC
做到gcc config的时候出现问题
```bash
../gcc-4.8.2/configure  --target=$LFS_TGT  --prefix=/tools  --with-sysroot=$LFS  --with-newlib  --without-headers  --with-local-prefix=/tools  --with-native-system-header-dir=/tools/include  --disable-nls  --disable-shared  --disable-multilib  --disable-decimal-float  --disable-threads  --disable-libatomic  --disable-libgomp  --disable-libitm  --disable-libmudflap  --disable-libquadmath  --disable-libsanitizer  --disable-libssp  --disable-libstdc++-v3  --enable-languages=c,c++  --with-mpfr-include=$(pwd)/../gcc-4.8.2/mpfr/src  --with-mpfr-lib=$(pwd)/mpfr/src/.libs
```
最后我再gcc的源代码文件夹里面新建了build
之后运行书里面的脚本 TODO还是没弄明白是什么意思这个脚本
config脚本
```bash
../configure  --target=$LFS_TGT  --prefix=/tools  --with-sysroot=$LFS  --with-newlib  --without-headers  --with-local-prefix=/tools  --with-native-system-header-dir=/tools/include  --disable-nls  --disable-shared  --disable-multilib  --disable-decimal-float  --disable-threads  --disable-libatomic  --disable-libgomp  --disable-libitm  --disable-libmudflap  --disable-libquadmath  --disable-libsanitizer  --disable-libssp  --disable-libstdc++-v3  --enable-languages=c,c++  --with-mpfr-include=../mpfr/src  --with-mpfr-lib=$(pwd)/mpfr/src/.libs
```
研究之后希望通过设定环境变量来解决 error: libmpfr not found or uses a different ABI 问题
理由是manual中提到
 if MPFR is already installed but it is not in your default library search path, the --with-mpfr configure option should be used. See also --with-mpfr-liband --with-mpfr-include. 
因此通过希望设定环境变量解决
```bash
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/mnt/lfs/tars/gcc-4.8.2/mpfr/src 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/lfs/tars/gcc-4.8.2/build/mpfr/src/.libs
```
#### 结果这么做还是徒劳的。
# 2014年7月4日 继续旅程
最后直接改成绝对路径来config成功了
```bash
../configure --target=x86_64-lfs-linux-gnu --prefix=/tools --with-sysroot=/mnt/lfs --with-newlib --without-headers --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --disable-nls --disable-shared --disable-multilib --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libitm --disable-libmudflap --disable-libquadmath --disable-libsanitizer --disable-libssp --disable-libstdc++-v3 --enable-languages=c,c++ --with-mpfr-include=/mnt/lfs/tars/gcc-4.8.2/mpfr/src --with-mpfr-lib=/mnt/lfs/tars/gcc-4.8.2/build/mpfr/src/.libs
```
之后遇到无厘头问题
```bash
configure:3565: checking for suffix of object files
configure:3587: /mnt/lfs/tars/gcc-4.8.2/build/./gcc/xgcc -B/mnt/lfs/tars/gcc-4.8.2/build/./gcc/ -B/tools/x86_64-lfs-linux-gnu/bin/ -B/tools/x86_64-lfs-linux-gnu/lib/ -isystem /tools/x86_64-lfs-linux-gnu/include -isystem /tools/x86_64-lfs-linux-gnu/sys-include    -c -g -O2  conftest.c >&5
/mnt/lfs/tars/gcc-4.8.2/build/./gcc/as: line 87: exec: --: invalid option
exec: usage: exec [-cl] [-a name] [command [arguments ...]] [redirection ...]
configure:3591: $? = 1
configure: failed program was:
| /* confdefs.h */
| #define PACKAGE_NAME "GNU C Runtime Library"
| #define PACKAGE_TARNAME "libgcc"
| #define PACKAGE_VERSION "1.0"
| #define PACKAGE_STRING "GNU C Runtime Library 1.0"
| #define PACKAGE_BUGREPORT ""
| #define PACKAGE_URL "http://www.gnu.org/software/libgcc/"
| /* end confdefs.h.  */
|
| int
| main ()
| {
|
|   ;
|   return 0;
| }
configure:3605: error: in `/mnt/lfs/tars/gcc-4.8.2/build/x86_64-lfs-linux-gnu/libgcc':
configure:3608: error: cannot compute suffix of object files: cannot compile
```
错误命令as经过查看是错误的软连接到binutils替换掉就好了
（这个乱七八糟的改名还有软连接太简单了不写代码了）
最后整理的时候还是写了一下
```bash
[#14#lfs@Dev /mnt/lfs/tars/gcc-4.8.2/build]$mv gcc/as gcc/as#
[#15#lfs@Dev /mnt/lfs/tars/gcc-4.8.2/build]$ln -s /tools/bin/as gcc/as
```

### 遭遇错误 x86_64-lfs-linux-gnu-ar 找不到
没关系 alias 直接搞定试试
```bash
alias x86_64-lfs-linux-gnu-ar=/tools/bin/ar
```
结果这种办法是远远不够的。

### 继续遭遇错误 x86_64-lfs-linux-gnu-ranlib 找不到
两个问题一起解决
```bash
#file: /bin/x86_64-lfs-linux-gnu-ranlib
#!/bin/bash
/tools/bin/ranlib $@

#file: /bin/x86_64-lfs-linux-gnu-ar
#!/bin/bash
/tools/bin/ar $@
```
这俩文件弄完了之后别忘了chmod +x 啊

### 小结一共遇到4个错误
+ config的坑，最后通过绝对路径搞定
+ 那个无厘头的as错误通过使用binutils搞定了（我还在想为啥用binutils做编译的开头呢。）
+ 找不到ar的那个命令 通过bin下写脚本搞定
+ 找不到ranlib的那个命令 通过bin下写脚本搞定

### 两个遗留问题
+ 开始的脚本没读懂
+ 36页最后的命令没看懂就没有做。

## Linux-3.13.3 API Headers 安装
毫无难度
## glibc 
首先检查rpc的header我看脚本之后自己手动检查了一下发现有就不管了。
然后正常编译

先试试这个
```bash
../configure --prefix=/tools --host=$LFS_TGT --build=$(../glibc-2.19/scripts/config.guess) --disable-profile --enable-kernel=2.6.32 --with-headers=/tools/include libc_cv_forced_unwind=yes libc_cv_ctors_header=yes libc_cv_c_cleanup=yes
```

config的时候出错有说不能包含自己目录的。
直接
```bash
unset LD_LIBRARY_PATH
```

make的时候selinux出错了。但是我感觉selinux没有必要啊。
我就改了一下config
```bash
../configure --prefix=/tools --host=x86_64-lfs-linux-gnu --build= --disable-profile --enable-kernel=2.6.32 --with-headers=/tools/include libc_cv_forced_unwind=yes libc_cv_ctors_header=yes libc_cv_c_cleanup=yes --without-selinux
```
后面加了一个--without-selinux结果make通过了


### Libstdc++-4.8.2
编译的时候很正常的出现了问题。
```bash
../configure --host=x86_64-lfs-linux-gnu --prefix=/tools --disable-multilib --disable-shared --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch --with-gxx-include-dir=/tools/lib/gcc/x86_64-lfs-linux-gnu/4.8.2/include  CXX=/tools/bin/x86_64-lfs-linux-gnu-g++
```
config的解决思路，首先刚开始的时候很正常的一个报错
之后我就感觉应该自己找include的位置自己添加
添加之后因为是4.8版本的include我就觉得不能用自己的4.4的编译器编译了。但是如果不用自己的gcc linker就会出问题
所以只改了CXX换成4.8版本的 
实测有效！

### binutils 二周目编译
```bash
CC=/tools/bin/x86_64-lfs-linux-gnu-gcc
AR=/tools/bin/x86_64-lfs-linux-gnu-gcc-ar
RANLIB=/tools/bin/x86_64-lfs-linux-gnu-gcc-ranlib
```
config正常，
最后一个脚本是为了后面预留出来一个ld
### GCC4.8.2 二周目

我的系统我还再做别的开发不能改环境
所以  改绝对路径了
```bash
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $(/tools/bin/x86_64-lfs-linux-gnu-gcc -print-libgcc-file-name)`/include-fixed/limits.h
```

之后make的时候发现之前编译的gcc还是有问题的。
不能ld这是什么情况
自己开始做测试解决问题
# 2014年7月7日 征程
##### 后来发现问题不能连接ld什么的。卧槽我头晕了。我不知道怎么回事。后来我合计合计是不是找不到新版的binuils啊。然后我就。给心比哪一的binutils加入到path里面了。就好了

```bash
export PATH=$PATH:/tools/bin
```
表示搞定

##### 然后configure 过不去了。还是找不到ld我打算安装binutils
我觉得pass1里面的内容都是很基础的。意思应该是让你更新系统吧，我觉得这样做是最稳定的。

## 新的思路
后来我就发现 pass1 跟pass2到底是什么意思了。原来是因为我们自己要构建自己的小系统之后才能编译。
版本号都跟ubuntu 14.04是对应上的爱我草。那不就正好是pass1过了的意思么。人家都帮我做完了我干啥还要做一遍啊。

### 重头开始就这么定了
## glibc 


根据情况来。好使
```bash
../configure --prefix=/tools --host=x86_64-lfs-linux-gnu --build=x86_64-unknown-linux-gnu --disable-profile --with-headers=/tools/include libc_cv_forced_unwind=yes libc_cv_ctors_header=yes libc_cv_c_cleanup=yes
```
## libc++
根据情况来。
```bash
 ../libstdc++-v3/configure --host=x86_64-lfs-linux-gnu --prefix=/tools --disable-multilib --disable-shared --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch --with-gxx-include-dir=/tools/include/
```
## binutils PASS2
来吧，关键的地方试试。

```bash
#config
../configure --prefix=/tools --disable-nls --with-lib-path=/tools/lib --with-sysroot
```

make报错
conftest.c:10:25: fatal error: isl/version.h: No such file or directory

