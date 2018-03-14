var express = require('express');
var app = express();
var crypto = require('crypto');
var EXPIRED_TIME = 60 * 1000;

app.get('/seed', function (req, res) {
  var now = new Date().valueOf();

  // return different seed per {EXPIRED_TIME}
  var dateTime = now - now % EXPIRED_TIME;

  // return seed
  var seed = crypto.createHash("md5").update(dateTime + '').digest('hex');
  var timeLong = dateTime + EXPIRED_TIME;
  var time = ISODateString(new Date(timeLong));
  res.send('{"seed":"' + seed + '","expires_at":"' + time + '","expires_at_long":"' + timeLong + '"}');
});

function ISODateString(d) {  
    function pad(n) {  
        return n < 10 ? '0' + n : n  
    }
    return d.getUTCFullYear() + '-'  
    + pad(d.getUTCMonth() + 1) + '-'  
    + pad(d.getUTCDate()) + 'T'  
    + pad(d.getUTCHours()) + ':'  
    + pad(d.getUTCMinutes()) + ':'  
    + pad(d.getUTCSeconds()) + '.'  
    + d.getUTCMilliseconds() + 'Z'  
}  

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});