# HTML 头部插入的坑。

1. 最近的项目都是需要navbar的。全部需要动态什么的。
结果头部插入的时候就出现了很多坑。


如果直接+html页面很多编辑器的页面就不干了。


结果这能这样
```HTML
            var newNode = document.createElement("div");
            newNode.innerHTML = result;
            $('body')[0].insertBefore(newNode,$('body')[0].firstChild);
```
虽然不完美（多加了一个DIV）
但是还算能正常解决问题。
