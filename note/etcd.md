# ETCD 的学的使用与学习过程

##  基础方面文档：
[admin-guide](https://coreos.com/etcd/docs/latest/admin_guide.html)
这个是一定要看的重点看etcdctl命令怎么用的，熟悉里面的也没啥用，还不如直接试用一下命令就行了

[cluster-guide](https://coreos.com/etcd/docs/latest/clustering.html)

前面启动三个节点的命令比较重要，其实关键在initial 里面先配置几个节点试试就行。

## 动态节点添加

```
1. 在etcdctl 里面 etcdctl member add [name] [peerurl]
2. 在添加的目标节点里面启动就行了。就这么简单。。。。输入完上面的命令之后会有提示环境变量怎么搞的，非常方便，
当然我推荐的方式是直接使用命令行，毕竟涉及的东西越少越好，命令可以参考之前的cluster guide里面启动命令。
需要修改的地方就是initial cluster参数，添加新的服务器就行，和最后的New改成exist就行了。
```

## 安全问题


## 如何使用


## 备份与灾难恢复。
