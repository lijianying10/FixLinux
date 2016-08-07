
set -x
set -e

IFACE='ens3'

echo $ZKID > /var/lib/zookeeper/myid
if [ -n "$ZKIPS" ]; then
    printf '%s' "$ZKIPS" | awk 'BEGIN { RS = "," }; { printf "server.%i=%s:2888:3888\n", NR, $0 }' >> /etc/zookeeper/conf/zoo.cfg
fi
sudo systemctl restart zookeeper
sleep 3
echo $ZKP >/etc/mesos/zk
echo $QUORUM > /etc/mesos-master/quorum
echo $HostIP > /etc/mesos-master/hostname
echo $HostIP > /etc/mesos-master/ip
echo $HostIP > /etc/mesos-slave/hostname
echo $HostIP > /etc/mesos-slave/ip
echo 'mesos,docker' > /etc/mesos-slave/containerizers
systemctl restart mesos-master
systemctl restart mesos-slave

cat > /etc/systemd/system/etcd.service << EOF
[Unit]
Description=etcd key-value store
Documentation=https://github.com/coreos/etcd

[Service]
ExecStart=/bin/etcd -name ${ETCDNAME} \
 -advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://${HostIP}:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token etcd-cluster-1 \
 -initial-cluster $ETCDCLUSTER \
 -initial-cluster-state new
Restart=always
RestartSec=10s
LimitNOFILE=40000

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl restart etcd
sleep 5
etcdctl set /coreos.com/network/config '{ "Network": "10.1.0.0/16" }'


systemctl restart marathon

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
systemctl restart flannel

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
ExecStart=/usr/bin/docker daemon --storage-driver=overlay --log-driver=journald --bip=\${FLANNEL_SUBNET} --mtu=\${FLANNEL_MTU}
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

sleep 2
systemctl daemon-reload
systemctl restart docker