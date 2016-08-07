
set -x
set -e

IFACE='ens3'

echo $ZKP >/etc/mesos/zk
echo $HostIP > /etc/mesos-slave/hostname
echo $HostIP > /etc/mesos-slave/ip
echo 'mesos,docker' > /etc/mesos-slave/containerizers
systemctl restart mesos-slave

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
sleep 2

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