// BASE SETUP
// =============================================================================

// call the packages we need
var express = require('express');						// call express
var mongoose = require('mongoose');						// call mongoose
var Seed = require('./api/models/QRGeneratorModel'); 	// created model loading here
var app = express();									// define our app using express
var bodyParser = require('body-parser');

// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/QRGeneratorDB');

// configure app to use bodyParser()
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 3000;					// set our port

// ROUTES FOR OUR API
// =============================================================================
var routes = require('./api/routes/QRGeneratorRoutes');	// importing route
routes(app); 											// register the route

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);
