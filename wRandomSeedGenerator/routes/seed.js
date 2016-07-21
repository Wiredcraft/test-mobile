var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/test/:seed/:exptime', function(req, res, next) {
	res.json({seed:req.params.seed,expiredTime:req.params.exptime});
});
router.get('/test/:seed', function(req, res, next) {
	if (!req.exp) {
		req.params.exptime = 123;
	};
	res.json({seed:req.params.seed,expiredTime:getExptime()});
});

/* GET users listing. */
router.get('/', function(req, res, next) {
	res.json({seed:getRandomSeed(16,32),expiredTime:getExptime()});
});


var EXPIRED_TIME = 1000 * 60 * 60;
function getExptime(){
	return new Date().getTime() + EXPIRED_TIME;
}
function getRandomSeed(radix, len){
	var ret = '';
	while(ret.length < len){
		ret += Math.random().toString(radix).substr(2);
	}
	console.log( ret );
	return ret.substr(ret.length - len);
}

module.exports = router;
