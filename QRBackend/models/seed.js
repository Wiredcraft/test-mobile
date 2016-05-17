var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var randomstring = require("randomstring");
var later = require("later");

var timeoutInterval = 60 * 1000;


var SeedSchema = new Schema({
	'data': {type: String, length: 32, default: randomstring.generate(32)},
	'expiredDate': {type: Date, default: new Date(Date.now() + timeoutInterval)}
});

SeedSchema.statics = {

	//timeoutFlag: {type: Boolean},

	newestSeed: function (callback) {
		// body...
		this.findOne({
			$query:{},
			$orderby:{_id:-1}
		}).exec(callback);
	},

	generate: function () {
		return new this({
			data: randomstring.generate(32),
			expiredDate: new Date(Date.now() + timeoutInterval)
		});
	}
};

mongoose.model('Seed', SeedSchema);