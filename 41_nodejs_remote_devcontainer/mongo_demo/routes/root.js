const { logger } = require('../logger')
var express = require('express');
var router = express.Router();

const dbo = require("../db/mongo");

/* GET home page. */
router.get('/', function(req, res, next) {
  let db_connect = dbo.getDb("test");
  db_connect
    .collection("test")
    .find({})
    .toArray(function (err, result) {
      if (err) {
        logger.error(err);
        throw err;
      }
      logger.info(result)
      res.render('index', { title: 'Express', result: result });
    });
});

module.exports = router;
