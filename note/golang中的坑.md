#golang中的坑

## 类型转换。
1. golang中的类型转换全都是通过类似C语言这种的atoi itoa这种的
1. session中的坑的解决办法
```go
strconv.Itoa(int(userSession.Get("loginTime").(int)))+"<br/>"
```
(import strconv)
