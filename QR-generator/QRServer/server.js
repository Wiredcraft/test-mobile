var express = require('express');
var app = express();
var random = require("randomstring");
var dayjs = require('dayjs');

app.route('/seed')
  .get(function (req, res) {
    // expires at 1 minute later
    var expires_at = dayjs().add(1, 'minute');
    var seed = { "seed": random.generate(), "expires_at": expires_at };
    res.json(seed);
  });

var port = process.env.PORT || 3000;
app.listen(port);
										


