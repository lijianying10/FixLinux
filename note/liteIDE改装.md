#LiteIDE改装
最近一直都在使用liteIDE做开发。公司的项目很紧张，但是在这个周末。还是偷偷的对liteIDE小不爽的地方进行了一些小的改造。

## IDE上的run按钮就是运行当前的go文件。
1. 首先我们项目运行只是运行统一或者少数的入口点每次点开固定的文档才能run真的是够了。
另外一个主要的原因在于liteIDE没有project管理支持。
2. 而且这个IDE貌似没有出很长时间一般的RCP平台都是有插件开发的。但是这没有插件开发（貌似是有。而且是用python写的）
但是，没找到文档（截至 2015年1月19日）也是醉了。

## 关键入口点还是我在google Code上找到的一个文档。
在配置中的LiteBuild里面有一个gosrc.xml 这个配置文件能修改buttion调用的命令。
好吧就只能用这个做自己脚本的入口了。
```xml
<action id="Run" img="blue/run.png" key="Ctrl+Alt+R;Ctrl+F5" cmd="sh" args="/Users/Li-jianying/run.sh" output="true" codec="utf-8" readline="true"/>
```
`cmd` `args` 就是它了。
## 展开无限的联想
首先用这个做了一个系统的统一入口点，我的主要问题在于项目选择上面。
因为我项目不多，同时也就做两个项目所以直接就在脚本里面写好项目选择
就可以了。类似这样。
``` sh
echo "项目选择器"
sh ~/h/run.sh
```
直接去run项目里面的run.sh
就ok了。
## 坑
```sh
echo 'XXX项目启动脚本'
export C=$(cd `dirname $0`; pwd)
cd $C
go run httpServer.go router.go pageload.go
```
别忘了cd进去你的项目文件目录。不然，我也不知道是那里。反正找不到脚本。
然后你就run不了了。

# Golang坑爹的Test
1. 
