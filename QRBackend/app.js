var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var fs = require('fs');
var mongoose = require('mongoose');
var setting  = require('./Config/setting');

var routes = require('./routes/index');
var users = require('./routes/users');
const join = require('path').join;
var models = join(__dirname, './models/');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);

// handle the normal and catched err

app.use(function (req, res, next) {
  var respondObj = req.respondObj;
  if (respondObj){
    res.contentType('json');
    res.send(JSON.stringify(respondObj));
    res.end();
  }else
    next();
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;


fs.readdirSync(models)
    .filter(file => ~file.indexOf('.js')).forEach(file => require(join(models, file)));

connect()
    .on('error', console.log)
    .on('disconnected', connect)
    .once('open', function(){});

//function listen () {
//  if (app.get('env') === 'test') return;
//  app.listen(port);
//  console.log('Express app started on port ' + port);
//}

function connect () {
  var options = {
    server: {
      socketOptions: { keepAlive: 1 },
      poolSize: 5
    }

  };
  return mongoose.connect(setting.db, options).connection;
}