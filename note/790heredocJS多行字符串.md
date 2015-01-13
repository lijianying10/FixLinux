
function heredoc(fn) {
    return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
    }

var tmpl = heredoc(function(){/*
!!! 5
html
include header
body
//if IE 6
.alert.alert-error
center 对不起，我们不支持IE6，请升级你的浏览器
a(href="http://windows.microsoft.com/zh-CN/internet-explorer/download-ie") | IE8官方下载
a(href="https://www.google.com/intl/en/chrome/browser/") | Chrome下载
include head
.container
.row-fluid
.span8
block main
include pagerbar
.span4
include sidebar
include footer
include script
*/});
