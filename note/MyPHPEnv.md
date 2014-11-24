# 我的php环境配置

## 系统： mac 10.10.1
首先先通过coding.net 安装homebrew

github在中国几乎用不了？ 还是我网速慢，反正是clone不回来的。
直接放到coding.net上克隆回来之后。
下载代码回到本地
之后移动相同的目录结构到/usr/local中就ok了。
主要移动两个。一个是/bin/brew另外一个是Library这个文件夹就ok了。

### 小bug解决。基本上权限问题，要不就是缺少目录什么的，都好解决。

## 安装服务：
```bash
brew install redis 
brew install memcache
brew install automake
pecl install redis
pecl install memcache
```
当然pecl 是php自动更新模块的程序，非常方便，我就专注于开发，我不想专注于环境。2333
## 服务启动：
redis-server /usr/local/etc/redis.conf

