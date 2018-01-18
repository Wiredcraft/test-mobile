'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var SeedSchema = new Schema({
	seed: {
		type: String
	}, 
	expires_at: {
		type: Date,
		default: Date.now
	}
});

module.exports = mongoose.model('Seed', SeedSchema);
