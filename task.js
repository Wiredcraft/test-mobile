const http = require('http');
const url = require('url');

http.createServer(function (req, res) {

    var path = url.parse(req.url).pathname;
    var result = {};

    if (path == '/seed') {
        var s = Math.random().toString(36).substring(2);
        var temp = new Date().getTime() + 60 * 1000;

        result = {
            code: 200,
            expires_at: temp,
            seed: s
        }
    } else {
        result = {
            code: 404,
            message: 'not found'
        }
    }

    res.end(JSON.stringify(result));
}).listen(8080);