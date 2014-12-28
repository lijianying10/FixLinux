#mongodb 密码设定
```bash
use admin
db.addUser('root','123456')
db.system.users.find()
#如果出现了你输入的账号就证明成功了
```
