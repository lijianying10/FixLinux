之前也是用MacPorts这个不是很好用啊。
首先是修改repo的问题没有搞定。
然后是安装死慢的问题。卧槽简直了。
后来还是发现HomeBrew比较靠谱。
因为他的安装位置固定，然后基本上都是编译好了的直接给你用了。非常方便！
官网 brew.sh 最下面有一个ruby 的脚本自动下载的哦。直接就安装了。
全部同意就ok了。只不过是修改几个文件夹的权限，需要密码。
之后brew install redis就能装软件了

卸载MacPorts：
```bash
sudo port -f uninstall installed
sudo rm -rf \
/opt/local \
/Applications/DarwinPorts \
/Applications/MacPorts \
/Library/LaunchDaemons/org.macports.* \
/Library/Receipts/DarwinPorts*.pkg \
/Library/Receipts/MacPorts*.pkg \
/Library/StartupItems/DarwinPortsStartup \
/Library/Tcl/darwinports1.0 \
/Library/Tcl/macports1.0 \
~/.macports
```
