#golang中单元测试的坑。
1. go test 后面是不加目录跟参数的
如果需要的话可以加个go test -v
2. 配置文件全部都需要copy位置。不然就会报错。
因为没有办法更换run root
