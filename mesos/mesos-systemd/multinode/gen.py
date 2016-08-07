import sys
MasterHost= '192.168.122.86,192.168.122.87,192.168.122.88'
SlaveHosts= '192.168.122.89'.split(',')
MasterHosts=MasterHost.split(',')

QUORUM=0

if len(MasterHosts)==1:
    QUORUM=1

if len(MasterHosts)==3:
    QUORUM=2

if len(MasterHosts)==5:
    QUORUM=3

if QUORUM==0:
    print "Humber master host error"
    sys.exit(1)

idx=0
ETCDCLUSTER=''
ETCDENDPOINTS=''
ZKP=''
for HostIP in MasterHosts:
   ETCDCLUSTER+="etcd"+str(idx)+"=http://"+HostIP+":2380,"
   ETCDENDPOINTS+="http://"+HostIP+":4001,http://"+HostIP+":2379,"
   ZKP+=HostIP+":2181,"
   idx+=1
ETCDCLUSTER = ETCDCLUSTER[0:-1]
ETCDENDPOINTS= ETCDENDPOINTS[0:-1]
ZKP= "zk://"+ZKP[0:-1]+"/mesos"

SlaveScript=open("slave.sh",'r').read()
MasterScript=open("master.sh",'r').read()

def Gen(ip,script,ix,ismaster):
    RES=""
    if ismaster:
        RES+="NUMHOSTS='"+str(len(MasterHosts)) + "'\n"
        RES+="ZKID='"+str(ix+1)+"'\n"
        RES+="ETCDNAME='etcd"+str(ix)+"'\n"
    RES+="ZKP='"+ZKP+"'\n"
    RES+="HostIP='"+ip+"'\n"
    RES+="QUORUM='"+str(QUORUM)+"'\n"
    RES+="ZKIPS='" + MasterHost + "'\n"
    RES+="ETCDCLUSTER='"+ETCDCLUSTER+"'\n"
    RES+="ETCDENDPOINTS='"+ETCDENDPOINTS+"'\n"
    RES+="set -x\n"
    RES+="set -e\n"
    open('out/'+ip+'.sh','w').write(RES+script)

idxm=0
for HostIP in MasterHosts:
    Gen(HostIP,MasterScript,idxm,1)
    idxm+=1

idx=0
for HostIP in SlaveHosts:
    Gen(HostIP,SlaveScript,idx,0)
    idx+=1


RES=""
for HostIP in MasterHosts+SlaveHosts:
    RES+="scp "+HostIP+".sh root@"+HostIP+":install.sh\n"
open('out/scp.sh','w').write(RES)

