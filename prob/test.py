#encoding:utf-8
import json
import urllib
import urllib2
import sys
import yaml
import os
# 依赖解决： pip install pyyaml
case = yaml.load(file(sys.argv[1])) #从控制台输入配置文件

DevCode="273c5cd2d4cce23c32dc5655685aff4c" # ajax通用安全参数接入，不推荐Cookie操作因为每次ajax都会传送Cookie。流量很高。
ReqToken=""
AccessToken=""
Gindex=0
baseurl = 'http://127.0.0.1:9090'

# post ajax post helper
def post(url,value):
    print "post to :",baseurl+url
    data = urllib.urlencode(value)
    req = urllib2.Request(baseurl+url, data)
    response = urllib2.urlopen(req)
    the_page = response.read()
    return the_page

# check_error 针对ajax返回结果判断服务器有没有报错
def check_error(resp):
    if json.loads(resp)['status']['code'] != '200':
        print resp
        print 'response error'
        return 1
    return 0

# inittoken_customer customer 类型token 初始化，其实是帮助登录的
def inittoken_customer():
    resp = post("XXXXXXXXXXXXXXXXXXXX",{
        'XXXXXXXXXXXX':"ea66f04",
        'XXXXXXXXX':"c7465f402bb3f02a585f57c634d579fc"
        })
    if check_error(resp) != 0 :
        return
    ReqToken = json.loads(resp)["data"][0]['request_token']
    return ReqToken

# inittoken_shop 跟上面类似是商家端
def inittoken_shop():
    resp = post("XXXXXXXXXXXXXXXXXXXX",{
        'XXXXXXXXXXXXXXXXXXXX':"f8ccab8",
        'XXXXXXXXXXXXXXXXXXXX':"273c5cdbd4cce2cc32dc5655685a6f4c"
        })
    if check_error(resp) != 0 :
        return
    ReqToken = json.loads(resp)["data"][0]['request_token']
    return ReqToken

# login_customer 客户登录
def login_customer():
    resp = post("XXXXXXXXXXXXXXXXXXXX",{
        'XXXXXXXXXXXXXXXXXXXX':ReqToken,
        'username':"XXXXXXXXXXXXXXXXXXXX@nou.com.cn",
        'password':"123",
        'code':DevCode
        })
    if check_error(resp) != 0 :
        return
    return json.loads(resp)["data"][0]['access_token']

# login_customer 商家登录
def login_shop():
    resp = post("XXXXXXXXXXXXXXXXXXXX",{
        'XXXXXXXXXXXXXXXXXXXX':ReqToken,
        'username':"XXXXXXXXXXXXXXXXXXXX@gmail.com",
        'password':"123",
        'code':DevCode
        })
    if check_error(resp) != 0 :
        return
    return json.loads(resp)["data"][0]['access_token']

# get_token_time 查看token剩余有效时间
def get_token_time(token):
    resp = post("XXXXXXXXXXXXXXXXXXXX",{
        'XXXXXXXXXXXXXXXXXXXX':token,
        })
    return resp

# printJSON 格式化JSON输出
def printJSON(src):
    print json.dumps(json.loads(src),indent=2)


## 开始主要测试业务

# init token

baseurl = case['server'] # 登录
if case['login']=='customer':
    ReqToken = inittoken_customer()
    AccessToken = login_customer()
else:
    ReqToken = inittoken_shop()
    AccessToken = login_shop()

# 执行yaml中的test case
for testcase in case['case']:
    if testcase['data'] == 'null':
        testcase['data'] = dict()
    testcase['data']['access_token']=AccessToken
    testcase['data']['request_token']=ReqToken
    testcase['data']['code']=DevCode
    printJSON(post(testcase['src'],testcase['data']))
