json tool 虽然好用，但是他有一个遇到中文就变unicode的问题
然后我们修改一下源代码
```
 34         json.dump(obj, outfile, sort_keys=True,
 35                   indent=4, separators=(',', ': '), ensure_ascii=False)
```
最后的ensure_ascii是关键
