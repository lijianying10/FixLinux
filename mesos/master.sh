set -e
set -x
docker run --rm -v /opt/:/data/ afafaf.newb.xyz/zookeeper:3.3.6
docker run --rm -v /opt/:/data/ afafaf.newb.xyz/etcd:2.3.7
docker run --rm -v /opt/:/data/ afafaf.newb.xyz/mesos:0.28.2
docker run --rm -v /opt/:/data/ afafaf.newb.xyz/marathon:1.1.1
docker run --rm -v /opt/:/data/ afafaf.newb.xyz/jdk:8u91

echo "Now instal"

mkdir -p /opt/etcd-2.3.7
mv /opt/etcd /opt/etcd-2.3.7
mv /opt/etcdctl /opt/etcd-2.3.7
cd /opt
tar xf jdk-8u91-linux-x64.tar.gz
tar xf marathon-1.1.1.tgz
tar xf mesos-0.28.2.tar.gz
tar xf zookeeper-3.3.6.tar.gz
rm jdk-8u91-linux-x64.tar.gz marathon-1.1.1.tgz mesos-0.28.2.tar.gz zookeeper-3.3.6.tar.gz
