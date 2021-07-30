const { logger, expresslogger } = require('./logger')

var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var stylus = require('stylus');
require("dotenv").config({ path: "./config.env" });
const dbo = require("./db/mongo");
// perform a database connection when server starts
dbo.connectToServer(function (err) {
  if (err) console.error(err);
});
var rootRouter = require('./routes/root');
var apiRouter = require('./routes/api');

var app = express();
app.use(expresslogger)
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hjs');

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(stylus.middleware(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', rootRouter);
app.use('/api', apiRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

let applogger = logger.child({attached_object:"Attaching objects to all child logs"})
applogger.trace("TRACE - level message")
applogger.debug("DEBUG - level message")
applogger.info("INFO - level message")
applogger.warn("WARN - level message")
applogger.error("ERROR - level message")
applogger.fatal("FATAL - level message")

module.exports = app;
