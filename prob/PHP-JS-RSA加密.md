#PHP-JS-RSA加密
###AUTH：PHILO EMAIL：lijianying12 at gmail.com

基于POST GET 的http通讯虽然非常成熟，但是很容易被人监听。
再这篇文章中我们为了降低服务器的成本，没有使用SSL而使用
RSA加密。文章中的php加密解密 JS的加密解密 互相加密解密
都能验证通过。

其中PHP依赖常见的OPENSSL LIB 。 JS依赖 jsencrypt。


## 首先要生成密匙对
```shell
openssl genrsa 1024 > private.key
openssl rsa -in private.key -pubout > public.key
```

##JS的RSA加密流程

下载最新版本请移步到github：[jsencrypt](https://github.com/travist/jsencrypt) 代码在目录BIN下面是否用压缩的根据情况决定。

### 生成KEY
```js
var keySize = 1024; //加密强度
var crypt = new JSEncrypt({default_key_size: keySize});  //RSA 操作对象
//方法1 (async)
crypt.getKey(function () {
	crypt.getPrivateKey();
	crypt.getPublicKey();
});
//方法2：
crypt.getKey();
crypt.getPrivateKey();
crypt.getPublicKey();
```

### 客户端加密场景：
```js
var crypt1 = new JSEncrypt(); //新建rsa对象
        var publickey = '\
        -----BEGIN PUBLIC KEY-----\
        MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3N8LJFqlsa6loCgFpgZVMr/Sx\
        DMQY7pr0euNQfh2g+UVPbB0MGhoc7nWL0FQhCgDedbjQw/nGFStFx7W1+0o1oRTY\
        u5ebNVivZSobraUv7LJvwT8O66Zs8cxbKLqQ/nE/WwJvXomSIckH6R8iOUO8/QT9\
        kv6/L0Uma3qA07pmDQIDAQAB\
        -----END PUBLIC KEY-----\
                ';
crypt1.setPublicKey(publickey );//添加来自服务端的publickey
crypt1.encrypt('abc'); //返回值为加密后的结果
```

### 客户端解密场景:
```js
        var privatekey = '-----BEGIN RSA PRIVATE KEY-----\
        MIICXQIBAAKBgQC3N8LJFqlsa6loCgFpgZVMr/SxDMQY7pr0euNQfh2g+UVPbB0M\
        Ghoc7nWL0FQhCgDedbjQw/nGFStFx7W1+0o1oRTYu5ebNVivZSobraUv7LJvwT8O\
        66Zs8cxbKLqQ/nE/WwJvXomSIckH6R8iOUO8/QT9kv6/L0Uma3qA07pmDQIDAQAB\
        AoGBAKba3UWModbfZXQeSJLxNCqWw9zJp3ydL/keQQ35DLqgyIJAD2QKEWXvtJUT\
        sMo19fyicSGOmFXQyYvPCKkmpLkOMAj1XaNpSMtSrcMx+gC01PO6Ey9rsUxW1g3u\
        fpqbEk9E3a5AtCS0I61nbUpRL6rqMtR5o2wcNR3TLtJt7pjxAkEA7hlFJKU1zWGp\
        OvvkJDnHc2NOCEJoGjqCR9wwv96+/xAykl2laI6WvEbbhjoO0+8+d17oigjhneS5\
        2UKFcfqw7wJBAMT+MCQ5TYLQlvjrBaDMqOdLsqtaDE6CpkrgwV820QMvHOo3R4Xd\
        uSbrA2tOr9t2/x+FzF971lRGdPFIch9UYMMCQQCZtO6SDaWCBP3++gX57OL5dq41\
        XsldxU+9nERMWTvr5UUAgDv8F7Dvsr6dFHXmE5i77yUnlzwvdi0UOIF1Z2U5AkBV\
        wyRKYPgx34Ya0JcerntKV1Zt60I4XADx0G/feAn/DN/VyENHMISPQPm4GgXN0jy4\
        CJQ1bcCd6B65fQTSRvXpAkA2Vv5yXzeKDls/AyxHEoros/VYftVc1HOFC++q13Rw\
        NH2rnlRT8FMTFEqL9MYRqvvYAFf5VmH0M1Nx5t4LRN+l\
        -----END RSA PRIVATE KEY-----\
                ';
var crypt2 = new JSEncrypt();//新建加密对象
crypt2.setPrivateKey(privatekey);//给加密对象设置privatekey
crypt2.getPublicKey();//Tip 我们是不需要存储publickey的直接用private能得到publickey
crypt2.decrypt("MeUqWB5LwTh8crzPqbZtEtKuZxYvPWH9CTCChK1qoBzIgIXGPCdzNMbiH0cCYHl5qWSERIDOgDIgv4dXsIMjEJ5q0cp/qNQYHM5va0iw0UvKvQB1E8aWtY2nFEPy4F+ArQ0Mj/ijr/CntEP1jHKC3WU9nu2kYrBIBnbj14Bs+kI=");//调用解密方法
```

####但是虽然写到了这里，加密方面还是不够用，因为1024长度的RSA加密最多只能加密长度为117的字符串。而URL长度最多为4k因此这里我们要让加密长度达到2691以达到能用的程度。

那么这种加密长度大概能容纳多少数据呢？
我们借助[json-generator](http://www.json-generator.com/)来帮忙生成JSON
```js
    sdata =[
        {
            "_id": "542f9ac2359c7d881bc0298e",
            "index": 0,
            "guid": "db1dacc1-b870-4e3c-bc1a-80dfd9506610",
            "isActive": false,
            "balance": "$1,570.15",
            "picture": "http://placehold.it/32x32",
            "age": 36,
            "eyeColor": "blue",
            "name": "Effie Barr",
            "gender": "female",
            "company": "ZORK",
            "email": "effiebarr@zork.com",
            "phone": "+1 (802) 574-3379",
            "address": "951 Cortelyou Road, Wikieup, Colorado, 4694",
            "about": "Sunt reprehenderit do laboris velit qui elit duis velit qui. Nostrud sit eiusmod cillum exercitation veniam ad sint irure cupidatat sunt consectetur magna. Amet nisi velit laboris amet officia et velit nisi nostrud ipsum. Cupidatat et fugiat esse minim occaecat cillum enim exercitation laboris velit nisi est enim aute. Enim do pariatur\r\n",
            "registered": "2014-05-08T15:26:35 -08:00",
            "latitude": 48.576424,
            "longitude": 146.634137,
            "tags": [
                "esse",
                "proident",
                "quis",
                "consectetur",
                "magna",
                "tempor",
                "anim"
            ],
            "friends": [
                {
                    "id": 0,
                    "name": "Trisha Cannon"
                },
                {
                    "id": 1,
                    "name": "Todd Bullock"
                },
                {
                    "id": 2,
                    "name": "Eileen Drake"
                },
                {
                    "id": 3,
                    "name": "Ferrell Kelly"
                },
                {
                    "id": 4,
                    "name": "Fischer Blankenship"
                },
                {
                    "id": 5,
                    "name": "Morales Mann"
                },
                {
                    "id": 6,
                    "name": "Brandie Pittman"
                },
                {
                    "id": 7,
                    "name": "Virgie Kerr"
                }
            ],
            "greeting": "Hello, Effie Barr! You have 1 unread messages.",
            "favoriteFruit": "apple"
        },
        {
            "_id": "542f9ac21c260d03e763a4f2",
            "index": 1,
            "guid": "9e3a3d8a-26f8-46b7-aca0-336a194808b1",
            "isActive": true,
            "balance": "$3,617.89",
            "picture": "http://placehold.it/32x32",
            "age": 31,
            "eyeColor": "brown",
            "name": "Butler Best",
            "gender": "male",
            "company": "SPORTAN",
            "email": "butlerbest@sportan.com",
            "phone": "+1 (905) 428-3046",
            "address": "798 Joval Court, Wanship, Delaware, 8974",
            "about": "Nostrud occaecat id sunt pariatur ad nisi do veniam sit officia non consequat amet fugiat. Est eiusmod labore ut cillum qui eu elit ut eiusmod exercitation. Ut anim nostrud eiusmod voluptate tempor proident id do pariatur. In Lorem ullamco ea irure adipisicing. Quis est dolor ex commodo aliqua nisi elit sit elit anim fugiat sunt amet. Enim consequat ipsum occaecat ipsum tempor deserunt dolor veniam nostrud. Anim cillum ullamco cupidatat aute velit fugiat sit enim in amet anim mollit dolor eiusmod.\r\n",
            "registered": "2014-08-02T06:15:44 -08:00",
            "latitude": -20.529765,
            "longitude": 2.396578,
            "tags": [
                "consequat",
                "enim",
                "magna",
                "sunt",
                "Lorem",
                "quis",
                "commodo"
            ],
            "friends": [
                {
                    "id": 0,
                    "name": "Kenya Rice"
                },
                {
                    "id": 1,
                    "name": "Hale Knowles"
                },
                {
                    "id": 2,
                    "name": "Michael Stephens"
                },
                {
                    "id": 3,
                    "name": "Holder Bailey"
                },
                {
                    "id": 4,
                    "name": "Garner Luna"
                },
                {
                    "id": 5,
                    "name": "Alyce Sawyer"
                },
                {
                    "id": 6,
                    "name": "Rivas Owens"
                },
                {
                    "id": 7,
                    "name": "Jan Petersen"
                }
            ],
            "greeting": "Hello, Butler Best! You have 8 unread messages.",
            "favoriteFruit": "banana"
        }
    ]
```

表单json能达到这么长已经是很极端的情况了。因此这种方法绝对是够用的。

###长表单内容加解密方法：
```js
function encrypt_data(publickey,data)
{
	if(data.length> 2691){return;} // length limit
	var crypt = new JSEncrypt();
	crypt.setPublicKey(publickey);
	crypt_res = "";
	for(var index=0; index < (data.length - data.length%117)/117+1 ; index++)
	{
		var subdata = data.substr(index * 117,117);
		crypt_res += crypt.encrypt(subdata);
	}
	return crypt_res;
}
function decrypt_data(privatekey,data)
{
	var crypt = new JSEncrypt();
	crypt.setPrivateKey(privatekey);
	datas=data.split('=');
	var decrypt_res="";
	datas.forEach(function(item)
	{
		if(item!=""){de_res += crypt.decrypt(item);}
	});
	return decrypt_res;
}
```


## PHP的RSA加密

### php加密解密类

首先要检查phpinfo里面有没有openssl支持

```php
class mycrypt {  
  
    public $pubkey;  
    public $privkey;  
  
    function __construct() {  
                $this->pubkey = file_get_contents('./public.key');  
                $this->privkey = file_get_contents('./private.key');  
    }  
  
    public function encrypt($data) {  
        if (openssl_public_encrypt($data, $encrypted, $this->pubkey))  
            $data = base64_encode($encrypted);  
        else  
            throw new Exception('Unable to encrypt data. Perhaps it is bigger than the key size?');  
  
        return $data;  
    }  
  
    public function decrypt($data) {  
        if (openssl_private_decrypt(base64_decode($data), $decrypted, $this->privkey))  
            $data = $decrypted;  
        else  
            $data = '';  
  
        return $data;  
    }  
  
}  
```

**密匙文件位置问题，是放到访问接口的附近就可以了如果是CI的话就放到index.php旁边就行了。**

### 类的使用
```php
$rsa = new mycrypt();  
echo $rsa -> encrypt('abc');  
echo $rsa -> decrypt('W+ducpssNJlyp2XYE08wwokHfT0bm87yBz9vviZbfjAGsy/U9Ns9FIed684lWjYyyofi/1YWrU0Mp8vLOYi8l6CfklBY=');  
```

###长数据加密解密
```php
function encrypt_data($publickey,$data)
{
    $rsa = new mycrypt();
    if($publickey != ""){
        $rsa -> pubkey = $publickey;
    }
    $crypt_res = "";
    for($i=0;$i<((strlen($data) - strlen($data)%117)/117+1); $i++)
    {
        $crypt_res = $crypt_res.($rsa -> encrypt(mb_strcut($data, $i*117, 117, 'utf-8')));
    }
    return $crypt_res;
}
function decrypt_data($privatekey,$data)
{
    $rsa = new mycrypt();
    if($privatekey != ""){  // if null use default
        $rsa ->privkey = $privatekey;
    }
    $decrypt_res = "";
    $datas = explode('=',$data);
    foreach ($datas as $value)
    {
        $decrypt_res = $decrypt_res.$rsa -> decrypt($value);
    }
    return $decrypt_res;
}
```
## JSONP 跨域通讯
我们经过千辛万苦经过加密终于能做到通讯安全了。
当然我们的下一步是通过JSONP 的get通讯来实现跨域通讯啦。
经过测试：我们的JS中最长的Case url长度是3956
再加上跨域url callbac参数，经过测试正好差20到4095 （一般的URI长度限制为4K）

```js
$.ajax({  
	type:"get",  
	async:false,  // 设置同步通讯或者异步通讯
	url:"http://22500e31b5a12457.sinaapp.com/ubtamat/getPubKey?c=hknHQKIy3dyeeajyAwZ+raUkV1ezFbgU8zk+54cNQtrcEGozUjXpYhbC6fxz2hCOgp9feIsM1xKJFm5pkAGQ2UcUOc5EJNCAz6L0mXkZbTBmh3PufWxOE7TaicqRCRtZGGNB2qpm2WruXjYg1lPcrPz/rhFZx4DSJvEHkCm7ZU0=......(加密后的结果太长，省略)",  
	dataType:"jsonp",
	jsonp: "",
}); 
```


```php
     header("Content-type: application/javascript; charset=utf-8");
     $response = "console.log('test response!')";
     $callback = $this->input->GET('callback');
     echo $callback.$response;
```
PHP代码是CI框架controler中的部分代码
并且经过了必要的裁剪。
更加细节的参数都放到GET里面就可以了。
处理之后按照上面的形式处理返回值就ok
