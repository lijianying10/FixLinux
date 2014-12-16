http://paradoxxxzero.github.io/2014/02/28/butterfly.html 
http://paradoxxxzero.github.io/2014/03/21/butterfly-with-ssl-auth.html

安装的时候注意ssl的devel libffi-dev就行了。
瞅瞅错误基本上就能编译过去了。

```sh
$ sudo butterfly.server.py --generate-certs --host="192.168.0.1" # Generate the root certificate for running on local network
$ sudo butterfly.server.py --generate-user-pkcs=foo              # Generate PKCS#12 auth file for user foo
```
cd /etc/butterfly/ssl/
butterfly_ca.crt这个是要 import到浏览器里面的
foo.p12这个哈。也是要import到浏览器里面的
之后访问host的那个ip地址就能用https 安全使用控制台了。

```sh
$ sudo butterfly.server.py --host="192.168.0.1" # Run the server
```
这是运行啦~~~
