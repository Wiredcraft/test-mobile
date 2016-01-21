var http = require('http');
var url = require('url');
var util = require('util');

function randomString() {
　　var len = 32;
　　var $chars = 'abcdefhijkmnprstwxyz2345678';    /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
　　var maxPos = $chars.length;
　　var data = '';
　　for (i = 0; i < len; i++) {
　　　　data += $chars.charAt(Math.floor(Math.random() * maxPos));
　　}
　　return data;
}

http.createServer(function(req, res){
    res.writeHead(200, {'Content-Type': 'text/plain'});
    var str = '';
    res.end(JSON.stringify({  
    "data": str = randomString() , 
    "len":str.length,
    "expiredAt": new Date().getTime() +''
}));
}).listen(8080);