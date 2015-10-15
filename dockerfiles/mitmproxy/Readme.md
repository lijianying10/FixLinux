# 使用方法说明：
构建完成之后使用如下脚本来做到hijacking

```
#!/usr/bin/env python
# coding=utf-8

 
def request(context, flow):
    if 'test.wifi.plus' == flow.request.host:
        if flow.request.scheme == "http":
            flow.request.host = "127.0.0.1"
            flow.request.port = 3000
```

命令 mitmproxy -p 8321 -s proxy.py

端口为http代理端口
脚本为上面的文件
