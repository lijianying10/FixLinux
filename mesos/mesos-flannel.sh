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

docker -H unix:///var/run/system-docker.sock run --name flannel -it -d -v /run/flannel/:/run/flannel/ --net=host --privileged flannel:0.5.5 /opt/bin/flanneld --ip-masq=true --iface=$IFACE -etcd-endpoints="http://$HostIP:4001,http://$HostIP:2379"


#run zk
docker -H unix:///var/run/system-docker.sock run -d -it \
-e MYID=$ZKID \
-e SERVERS=$ZKIPS \
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
-v /root/:/root/ \
-v /var/run/docker.sock:/var/run/docker.sock \
--name mesos-slave --net host --privileged --restart always \
$REG/mesos-slave:0.28.1-centos-7

# run in single docker

#docker -H unix:///var/run/system-docker.sock run -d \
#-v /sys/fs/cgroup:/sys/fs/cgroup \
#-v /var/run/docker.sock:/var/run/docker.sock \
#--name marathon --net host --privileged --restart always \
#$REG/mesos-single-docker:1

cat > /root/dns.cfg <<EOF
{
  "zk": "zk://$HostIP:2181/mesos",
  "masters": ["$HostIP:5050"],
  "refreshSeconds": 60,
  "ttl": 5,
  "domain": "mesos",
  "port": 53,
  "resolvers": ["223.5.5.5"],
  "timeout": 5,
  "httpon": true,
  "dnson": true,
  "httpport": 8123,
  "externalon": true,
  "SOAMname": "ns1.mesos",
  "SOARname": "root.ns1.mesos",
  "SOARefresh": 60,
  "SOARetry":   600,
  "SOAExpire":  86400,
  "SOAMinttl": 60,
  "IPSources": ["netinfo", "mesos", "host"]
}
EOF

wget http://git.oschina.net/lijianying10/mesos-dep/raw/master/mesos-dns-v0.5.2-linux-amd64 -O /root/mesos-dns

cat > /root/dns.json << EOF
{
    "cmd": "/root/mesos-dns -config=/root/dns.cfg",
    "cpus": 0.3,
    "mem": 128,
    "id": "mesos-dns",
    "instances": 1,
    "constraints": [["hostname", "CLUSTER", "$HostIP"]]
}
EOF

chmod +x mesos-dns
curl -i -H 'Content-Type: application/json' -d @dns.json http://$HostIP:8080/v2/apps

