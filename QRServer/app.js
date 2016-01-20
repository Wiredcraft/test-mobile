var express = require('express');
var app = express();
var fs = require("fs");

app.get('/seed', function (req, res) {
    var seed = JSON.stringify({  
        "data": str = randomString() , 
        "len":str.length,
        "expiredAt": new Date().getTime() +''
    })
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end( seed );
    fs.appendFile('./log/log.txt', seed + '\n', 'utf-8');
})

var server = app.listen(8080, function () {
  var host = server.address().address
  var port = server.address().port
  console.log("访问地址为 http://%s:%s", host, port)
})

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