#MongoDB 存储过程的使用以及性能调优方案。
AUTH：PHILO
> [在2012年的一个blog里面看到了一个关于性能问题](在2012年的一个blog里面看到了一个关于性能问题)

虽然MongoDB给了我们很多驱动可以用，但是都没有mongodb的shell来的方便。
就比如说最近需要做的DBRef嵌套类型的数据要做CRUD如果使用mog驱动的话会非常麻烦。
因此我们这里来做个试验，首先给`test`数据库添加初始化数据添加Server-side script 
以及测试

## mongo 添加数据

```js
db.people.insert({"_id":"test","phone","233333"}) //输入原始数据


// 数据库修改函数
// update之后返回修改后的数据。
peopleUpdate=function(id,phone){
db.people.update({
"_id":id,
},{$set:{
phone:phone
}});
return db.people.findOne({"_id":id});
}

//添加数据库函数
 db.system.js.insert({"_id":"peopleUpdatePhone","value": peopleUpdate });
 // 修改数据库函数
 db.system.js.update({"_id":"peopleUpdatePhone"},{$set:{"value": peopleUpdate }})
 //执行数据库函数
 db.eval("peopleUpdatePhone('test','23333test')")

```
测试之后在mongo shell里面是ok的。

## golang 调用函数并返回
```
package main

import (
        "labix.org/v2/mgo"
        "labix.org/v2/mgo/bson"
       )

func main() {
	session, err := mgo.Dial("")
	if err != nil {
	    panic(err)
	}
	defer session.Close()

	session.SetMode(mgo.Monotonic, true)

	db := session.DB("test")
	var result interface{}
	db.Run(bson.M{"eval": "peopleUpdatePhone('test','new test');"},&result)
}
```

如上面代码所示，就可以执行修改了。
但是要注意[锁的问题](http://francs3.blog.163.com/blog/static/405767272012112811268129/)：eval会产生写入锁。结果你懂得。

## 性能测试。
> 我直接测试了调用main函数10000次

1. eval 
	1. 在测试中eval表现不佳，因为会锁库。
	1. 顺便吐槽一下mongodb的锁那真的是相当的大。
	1. 最后测试我每等到结果，甚至有几次修改一次要用4秒钟。（因为之前的锁没打开。）
1. runCommand
	1. 会快很多很多
	1. 2w次update同一个key的操作大概是3s。



##总结
1. 我用的是MBP MGX82
2. 虽然性能不是很好（跟MYSql还是差很多）但是以及够支持一般的应用了
3. 不是MongoDB不暴力，仅仅是因为我不懂而已。


