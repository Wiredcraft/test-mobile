'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var SeedSchema = new Schema(
	seed: {
		type: string
	}, 
	expires_at: {
		type: Date,
		default: Date.now
	}
);

module.exports = mongoose.model('Seed', SeedSchema);
