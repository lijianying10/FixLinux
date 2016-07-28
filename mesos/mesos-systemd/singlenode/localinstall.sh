set -x
set -e

# CONFIG

HostIP='192.168.56.112'
IFACE='enp0s3'

ETCDENDPOINTS="http://$HostIP:4001,http://$HostIP:2379"

## FILE: http://git.oschina.net/lijianying10/mesosrpm
tar xf MesosMarathonZK.tar.gz
cd mm
rpm -Uvh *
cd ..
## FILE: http://git.oschina.net/lijianying10/etcdflannel
mv etcd /bin/
mv etcdctl /bin/
mv flanneld /bin/

echo $HostIP > /etc/mesos-slave/hostname
echo 'mesos,docker' > /etc/mesos-slave/containerizers
echo 1 > /var/lib/zookeeper/myid
sudo systemctl start zookeeper
echo zk://$HostIP:2181/mesos >/etc/mesos/zk
echo 1 > /etc/mesos-master/quorum
systemctl start mesos-master
systemctl start mesos-slave

cat > /etc/systemd/system/etcd.service << EOF
[Unit]
Description=etcd key-value store
Documentation=https://github.com/coreos/etcd

[Service]
ExecStart=/bin/etcd -name etcd0 \
 -advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://${HostIP}:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster etcd0=http://${HostIP}:2380 \
 -initial-cluster-state new
Restart=always
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start etcd
sleep 5
etcdctl set /coreos.com/network/config '{ "Network": "10.1.0.0/16" }'



cat > /etc/systemd/system/flannel.service << EOF
[Unit]
Description=flannel vlan network
After=network.target docker.socket

[Service]
ExecStart=/bin/flanneld --ip-masq=true --iface=$IFACE -etcd-endpoints=$ETCDENDPOINTS
Restart=always
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start flannel

cat > /usr/lib/systemd/system/docker.service << EOF
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
EnvironmentFile=/run/flannel/subnet.env
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/docker daemon --log-driver=journald --bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl restart docker
