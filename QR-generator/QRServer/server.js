var express = require('express');
var app = express();
// generate random string
var random = require("randomstring");
// a lite,immutable date library
var dayjs = require('dayjs');

app.route('/seed')
  .get(function (req, res) {
    // expires at 1 minute later
    var expires_at = dayjs().add(1, 'minute');
    // build response body
    var seed = { "seed": random.generate(), "expires_at": expires_at };
    res.json(seed);
  });

var port = process.env.PORT || 3600;
app.listen(port);
										


