# Config
REG=docker.elenet.me/jianying.li
##REG=index.alauda.cn/philo
##REG=afafaf.newb.xyz
HostIP=192.168.56.101
#HostIP=192.168.81.110
IFACE=eth0

ZKID=1
ZKIPS=$HostIP
ETCDNAME=etcd0
ETCDCLUSTER='etcd0=http://$HostIP:2380'

# systemd:

wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/docker.service -O /usr/lib/systemd/system/docker.service
wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/system-docker.service -O /usr/lib/systemd/system/system-docker.service
wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/system-docker.socket -O /usr/lib/systemd/system/system-docker.socket

# start system-docker
systemctl daemon-reload
systemctl restart system-docker

 
# deploy flannel:

docker -H unix:///var/run/system-docker.sock pull $REG/flannel:0.5.5
docker -H unix:///var/run/system-docker.sock tag $REG/flannel:0.5.5 flannel:0.5.5

#runflannel:

docker -H unix:///var/run/system-docker.sock run --name flannel -it -d -v /run/flannel/:/run/flannel/ --net=host --privileged flannel:0.5.5 /opt/bin/flanneld --ip-masq=true --iface=$IFACE -etcd-endpoints="http://$HostIP:4001,http://$HostIP:2379"

# run user-docker
systemctl restart docker

# run mesos-slave

docker -H unix:///var/run/system-docker.sock run -d \
-e MESOS_HOSTNAME=$HostIP \
-e MESOS_IP=$HostIP \
-e MESOS_MASTER=zk://$HostIP:2181,$HostIP:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /root/:/root/ \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesos-slave --net host --privileged --restart always \
$REG/mesos-slave:0.28.1-centos-7

