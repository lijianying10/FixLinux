#Golang web 代码COPY手册
我们从来都不开发代码，我们只是代码的搬运工。
**-- 阿飞**

希望大家都变卡卡西。 **--啊贱**

大家copy愉快，文档只做参考。不行的地方别忘了给我发issue。

## golang web 开发check list
### 本章节提供golang web开发的知识面参考。
1. 基础知识全部略过，包含内容：
  1. 流程控制
  2. OOP
  3. 基础语法知识
1. 路由器
  1. 手动路由
  2. 自动路由
2. 页面加载
  1. 纯静态页面（推荐，前后分离，工程好做。）
  2. 模板页面（gtpl模板，浪费cpu以及调试困难等因素还是算了）
1. 表示层脚本(JS)
  1. require.js
  2. jquery
1. 业务层
  1. Get
  3. post
  3. 资源获取url
1. 持久层
  1. 框架
  1. Mysql
  1. MongoDB
1. 数据库参考
  1. 设计参考
1. 持久层驱动下载
1. 单元测试注意事项

## 路由器
> 路由器是整个网站对外的灵魂，如果路由做的不好URL会非常恶心。
所以这部分设计成第一个要说的内容。

> 路由分两种一种是手动路由为了通过tul调度固定的功能，另外一点就是资源
的获取，通过url的分析来模仿静态页的方式来获取资源（类似get）

> 自动路由，主要使用OOP的COMMAND模式来实现。所有功能使用post，
统一入口，方便权限管理，安全管理，跨域管理。

### 手动路由

```go
package main

import (
  "log"
  "net/http"
  )

  func main() {
    RouterBinding() // 路由绑定函数
    err := http.ListenAndServe(":9090", nil) //设置监听的端口
    if err != nil {
      log.Fatal("ListenAndServe: ", err)
    }
  }

```
在httpserver运行之前先绑定路由

#### 手动路由的绑定
1. 静态文件
```go
http.Handle("/pages/", http.StripPrefix("/pages/", http.FileServer(http.Dir("./pages"))))
```
1. 固定函数与资源获取

  他们都是一样的
  ```go
  http.HandleFunc("/images/", fileUpload.DownloadPictureAction)
  ```


### 自动路由
> TODO:坑


## 页面加载
1. 纯静态页（HTML）
> 直接交给路由就行了。自动就访问那个文件夹了。其他功能再补充吧。
主要好处前后分离，能上CDN就是通讯次数多了。不过通过优化改善之类的都还ok啦。

2. 模板页面的加载

```go
commonPage, err := template.ParseFiles("pages/common/head.gtpl", //加载模板
"pages/common/navbar.gtpl", "pages/common/tail.gtpl")
if err != nil {
  panic(err.Error())
}
navArgs := map[string]string{"Home": "home", "User": "yupengfei"}//复杂的参数开始往里塞

knowledgePage, err := template.ParseFiles("pages/knowledge/knowledge.gtpl")
knowledgeArgs := map[string]interface{}{"Head": "This is a test title",
"Author": "kun.wang", "PublishDatetime": "2014-09-14",
"Content": template.HTML("<p style=\"text-indent: 2em\">为什么要用语义呢？</p>")}//不是不好，只是做字符串分析会影响工程效率
commonPage.ExecuteTemplate(w, "header", nil)// render 开始
commonPage.ExecuteTemplate(w, "navbar", navArgs)
knowledgePage.ExecuteTemplate(w, "knowledge", knowledgeArgs)
commonPage.ExecuteTemplate(w, "tail", nil)
```

仅提供关键代码。
其他的自行打开脑洞吧。
 > 1. 其他的都还挺好，就是页面渲染用服务器是不是有点太奢侈了。
 > 2. 然后就是一堆参数来回塞入，进去
 > 3. 最后终于开始渲染了
 > 4. 总结：虽然减少的通讯次数，但是没办法上CDN蛋疼，另外，模板的mapping蛋疼。

## 表示层脚本

表示层脚本做的比较困难也不是很好学。
但是一旦搞定了，代码的复用性会有非常可观的提升。
>就普通情况而言JS开发效率是非常高的灵活度高，并且使用的是客户端的cpu
性能好，免费资源多，学习的人也多，好招聘。（济南除外）


### require.js

1. 加载

  ```js
  <script data-main="/reqmod/login_main" language="JavaScript" defer async="true" src="js/r.js"></script>
  ```
  整个网页之留这么一个加载脚本的入口（每个页面最好只有一个js文件）

  【好处】

  1. js是延迟加载。不会出现网页卡死的情况
  2. 最大化使用缓存。（HTTP 304）

  【坏处】

  1. 学习比较难
  2. 网站更新始终有缓存没更新的浏览器。造成错误（所以有些情况客户自己就知道多刷新几次了，已经成用户习惯了）

  【参数解释】

  1. `data-main` 业务逻辑入口，载入当前字符串.js这个文件
  2. `language` 不解释
  3. `defer async` 字面意思
  4. `src` r.js就是require.js的意思。代码到处都能搞到。

2. 页面Business
  1. 加载依赖文件
  ```js
  require.baseUrl = "/"
  require.config({
    baseUrl: require.baseUrl,
    paths: {
      "jquery": "js/jquery-1.10.2.min",
      "domready" : "reqmod/domReady",
      "pm" : "reqmod/pmodal",
      "cookie":"reqmod/cookie",
      "user":"reqmod/user",
      "bootstrap": "reqmod/bootstrap.min",
      "nav":"reqmod/nav"
    },
    shim: {
      'bootstrap': {
        deps: ['jquery']
      }
    }
  });
  ```
  直接copy全搞定。

  1. 执行页面business
    > 执行里面做的最多的就是dom跟事件绑定而已。加载各种js库直接引用。
    代码美观，开发效率，执行效率都是非常棒的。

    ```js
    require(['nav','domready', 'jquery', 'user','pm'], function (nav,doc, $, user,pm){
      //binding event is ok！
      doc(function () {
        pm.load();//加载各种插件HTML模板之类的都ok
        $('#btn_login')[0].onclick = function(){user.login();}//button 事件绑定

      });
    });
    ```
    1. `require` 这个函数里面第一个参数是上面声明的里面的key
    1. `function` 中的参数跟左边的对应，如果没有操作符，或者知识依赖于`$`（JQuery） 那么只在第一个参数中声明就ok了。**注意顺序是对应的**
    1. `doc` dom ready API 是等待dom加载完成之后执行的函数

    【总结】

    1. 有了这个库之后页面只需要一个js文件，再也不乱了。
    1. 有了这个库之后页面事件绑定只需要id（或者说DOM能找到就ok）

  1. 页面MODEL
    ```js
    define(['jquery','reqmod/cookie','user','bootstrap'],function ($,cookie,user){
      var nav_load = function () {
        $.get('/nav.html', function(result){
          var newNode = document.createElement("div");
          newNode.innerHTML = result;
          $('body')[0].insertBefore(newNode,$('body')[0].firstChild);
          //document.body.innerHTML = result + document.body.innerHTML;
          $('#btn_login')[0].onclick = function(){user.login();}
          $('#btn_reg')[0].onclick = function(){window.location='/register.html'}
          $.post('/login_check',{},function(data){
            if(data==0){
              Form_login.style.display=""
            }
            else{
              form_userInfo.style.display=""
            }
          })
        });

      }

      return {
        load :nav_load
      };
    });
    ```
    这个人require很像，但是函数叫`define`
    参数全是一样的
    但是

    【注意】
    > 这里引用的路径（单引号里面的依赖）一定要跟页面主business文件中有path配置，不然就要写网站绝对路径。T.T吃了不止一次亏。

    【函数的定义】

    ```js
    var nav_load = function () {}
    ```
    只接受var匿名函数定义。

    【最后的return】

    注意其实就是个微型路由。假定你又很多调试方案，来回测试的时候使用不同的业务直接修改路由就行了。很方便。

### JQuery
 >  TODO: 坑

## 业务层
  1. GET分析
   > TODO: 坑

  1. Post分析
    ```go
    func XXXAction(w http.ResponseWriter, r *http.Request) {
      r.parseForm() //有这个才能获取参数
      r.Form["Email"] // 获取Email 参数（String）
    }
    ```
    然后做业务就行了。

  1. 资源入口函数资源require分析（url分析固定写法）
    ```go
    func Foo(w http.ResponseWriter, r *http.Request) {
      queryFile := strings.Split(r.URL.Path, "/")
      queryResource := queryFile[len(queryFile)-1] // 解析文件
    }
    ```
    完成字符串分割之后，按照需求来获取资源就可以了。
## 持久层
  ### 框架
  > 没映射不开心，

    1. 我得兼容所有的系统，所以要设定专门的object做数据库的CRUD
    2. OBJ GET SET ok~

  ### Mysql
  > 在观察代码的时候有个方便的方法就是去掉异常处理的部分 if err XXXXX那些都去掉。就好看多了

  > 怎么说呢golang的err处理来回嵌套一次一次的，卧槽，让你迷糊都。之后会在utility
  里面直接处理，会方便很多。

  > 其实不管什么语言的Mysql驱动都是从PRO\*C来的，所以会PRO\*\C之后，
  啥都好说了就

    1. Insert Delete Update
    ```go
    stmt, err := mysqlUtility.DBConn.Prepare("INSERT INTO credit (credit_code, user_code, credit_rank) VALUES (?, ?, ?)")
    if err != nil {
      pillarsLog.PillarsLogger.Print(err.Error())
      return false, err
    }
    defer stmt.Close()
    _, err = stmt.Exec(credit.CreditCode, credit.UserCode, credit.CreditRank)
    if err 	!= nil {
      return false, err
      } else {
        return true, err
      }
    ```
    这个SQL fetch做的还是算比较人道的。
    1. Query
    ```go
    stmt, err := mysqlUtility.DBConn.Prepare(`SELECT commodity_code, commodity_name, description, picture,
      price, storage, count, status,
      insert_datetime, update_datetime FROM commodity WHERE commodity_code = ?`)
      if err != nil {
        return nil, err
      }
      defer stmt.Close()
      result, err := stmt.Query(commodityCode)
      if err != nil {
        return nil, err
      }
      defer result.Close()
      var commodity utility.Commodity
      if result.Next() {
        err = result.Scan(&(commodity.CommodityCode), &(commodity.CommodityName), &(commodity.Description),
        &(commodity.Picture), &(commodity.Price), &(commodity.Storage), &(commodity.Count), &(commodity.Status),
        &(commodity.InsertDatetime), &(commodity.UpdateDatetime))
        if err != nil {
          pillarsLog.PillarsLogger.Print(err.Error())
          return nil, err
        }
      }
      return &commodity, err
    ```
  ### Mongodb
  ```go
  err := 	mongoUtility.PictureCollection.Find(bson.M{"picturecode":*pictureCode}).One(&picture)
  ```
  啥都不说了。都再MongoDB参考书上呢，API都一样。（BSON显式声明除外。）

##数据库设计参考
  1. mysql数据库不能用id链接
  1. mongodb index 代价很大，来个有意义的hash `_id` 比啥都强。

## 单元测试注意事项
  1. 测试命令 go test -v （没有其他参数了！！！） `如果不带-v只显示结果，不显示调试过程，主要是调试开发的时候用`
  1. 文件格式 xxx_test.go 但是建议改成 xxx_test0.go 或者喜欢改成别的也可以。
    1. 由于测试先行的原则，在开发的时候一次测试也就一两个函数。
    1. 这样相当于把其他测试注释掉
  1. 测试的时候的配置文件要放到测试目录下面。别忘了。
  1. 还有系统要生成的（只做追加的打开找不到文件就启动不了。）持久化数据。要touch（新建）好
  1. 心态，错误太多一个一个来，要有个好心态。
  1. 运气，妈妈问你为啥跪着看LiteIDE你就说。。。。。。
