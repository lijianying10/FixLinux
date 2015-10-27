# docker 修改默认aufs存储位置

在配置文件：
/etc/defaults/docker 中
添加

```
DOCKER_OPTS="-g /data/docker"
```

其实就是docker daemon 中有个-g 用起来就好了
