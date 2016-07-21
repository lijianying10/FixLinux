# Config
REG=docker.elenet.me/jianying.li
##REG=index.alauda.cn/philo
##REG=afafaf.newb.xyz
HostIP=192.168.56.101
#HostIP=192.168.81.110

# systemd:

wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/docker.service -O /usr/lib/systemd/system/docker.service
wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/system-docker.service -O /usr/lib/systemd/system/system-docker.service
wget https://raw.githubusercontent.com/lijianying10/FixLinux/master/mesos/docker-systemd/system-docker.socket -O /usr/lib/systemd/system/system-docker.socket

# start system-docker
systemctl daemon-reload
systemctl restart system-docker

# get-etcd:
docker -H unix:///var/run/system-docker.sock pull  $REG/etcd:2.3.7
docker -H unix:///var/run/system-docker.sock tag $REG/etcd:2.3.7 etcd:2.3.7


#system-docker-etcd:


docker -H unix:///var/run/system-docker.sock run -it --net=host --privileged -d --name etcd etcd:2.3.7\
 /etcd -name etcd0 \
 -advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://${HostIP}:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://${HostIP}:2380 \
 -initial-cluster-state new
 
# deploy flannel:

docker -H unix:///var/run/system-docker.sock pull $REG/flannel:0.5.5
docker -H unix:///var/run/system-docker.sock tag $REG/flannel:0.5.5 flannel:0.5.5

# Add flannel subnet:
docker -H unix:///var/run/system-docker.sock exec -it etcd /etcdctl set /coreos.com/network/config '{ "Network": "10.1.0.0/16" }'

#docker -H unix:///var/run/system-docker.sock run -it --rm --net=host  etcd:2.3.7 /etcdctl set /coreos.com/network/config '{ "Network": "10.1.0.0/16" }'

#curl -L -X PUT http://127.0.0.1:2379/v2/keys/coreos.com/network/config -d value='{ "Network": "10.1.0.0/16" }'

#runflannel:

docker -H unix:///var/run/system-docker.sock run --name flannel -it -d -v /run/flannel/:/run/flannel/ --net=host --privileged flannel:0.5.5 /opt/bin/flanneld --ip-masq=true --iface=enp0s3 -etcd-endpoints="http://192.168.56.101:4001,http://192.168.56.101:2379"


#run zk
docker -H unix:///var/run/system-docker.sock run -d -it \
-e MYID=1 \
-e SERVERS=$HostIP \
-v /var/lib/zookeeper:/root/zookeeperbackup \
--name=zookeeper --net=host --privileged --restart=always $REG/zookeeper:3.4.7-centos-7

# run Mesos

docker -H unix:///var/run/system-docker.sock run -d \
-e MESOS_HOSTNAME=$HostIP \
-e MESOS_IP=$HostIP \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://$HostIP:2181,$HostIP:2181/mesos \
--name mesos-master --net host  --privileged --restart always $REG/mesos-master:0.28.1-centos-7

#run marathon

docker -H unix:///var/run/system-docker.sock run -d \
-e MARATHON_HOSTNAME=$HostIP \
-e MARATHON_HTTPS_ADDRESS=$HostIP \
-e MARATHON_HTTP_ADDRESS=$HostIP \
-e MARATHON_MASTER=zk://$HostIP:2181,$HostIP:2181/mesos \
-e MARATHON_ZK=zk://$HostIP:2181,$HostIP:2181/mesos \
--name marathon --net host --privileged --restart always $REG/marathon:1.1.1-centos-7

# run user-docker
systemctl restart docker

# run mesos-slave

docker -H unix:///var/run/system-docker.sock run -d \
-e MESOS_HOSTNAME=$HostIP \
-e MESOS_IP=$HostIP \
-e MESOS_MASTER=zk://$HostIP:2181,$HostIP:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesos-slave --net host --privileged --restart always \
$REG/mesos-slave:0.28.1-centos-7

# run in single docker

#docker -H unix:///var/run/system-docker.sock run -d \
#-v /sys/fs/cgroup:/sys/fs/cgroup \
#-v /var/run/docker.sock:/var/run/docker.sock \
#--name marathon --net host --privileged --restart always \
#$REG/mesos-single-docker:1