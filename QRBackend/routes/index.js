var express = require('express');
var router = express.Router();
var later = require('later');
var RespondHandler = require('../controllers/respondHandler.js');

require('../models/seed.js');
var mongoose = require('mongoose');
var Seed = mongoose.model('Seed');

var updateSchedule = later.parse.text('every 1 min');

later.setInterval(function () {
  var seed = Seed.generate();
  console.log(seed);
  seed.save();
}, updateSchedule);

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/seed', function(req, res, next){
  Seed.newestSeed(function (err, seed) {
    if (seed){
      RespondHandler.normal(req, next, seed);
    }else if(err) {
      RespondHandler.serverErr(req, next);
    }else {
      RespondHandler.err(req, next, 'no seed');
    }
  });

});

module.exports = router;
