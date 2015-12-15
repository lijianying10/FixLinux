0.4.1 以及之前一个版本的RC可以通过这样添加不安全REPO：

ros c set rancher.docker.args '[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G,docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false,--insecure-registry,c.reg:5000]'

重启不会丢失。

