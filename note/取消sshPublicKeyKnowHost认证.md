## 因为CoreOS每次启动之后都会更换public key

操作：
File：~/.ssh/config
```
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
```