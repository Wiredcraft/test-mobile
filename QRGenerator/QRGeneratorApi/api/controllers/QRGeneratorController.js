'use strict';

var mongoose = require('mongoose'),
	Seed = mongoose.model('Seed');

var randomString = require("randomstring");

exports.create_seed = function(req, res) {
	var new_seed = new Seed()
	new_seed.seed = randomString.generate();

	var now = new Date();
	new_seed.expires_at = new Date(now.getTime() + (1 * 1000 * 60)); // expires at 1 minute later
	res.json(new_seed);
};