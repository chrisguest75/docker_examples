const { logger } = require('../logger')
const os = require('os');
var express = require('express');
var router = express.Router();

const dbo = require("../db/mongo");

// This section will help you get a list of all the records.
router.route("/test").get(function (req, res) {
  let db_connect = dbo.getDb("test");
  db_connect
    .collection("test")
    .find({})
    .toArray(function (err, result) {
      if (err) {
        logger.error(err);
        throw err;
      }
      res.json(result);
    });
});

// This section will help you create a new record.
router.route("/test").post(function (req, res) {
  let db_connect = dbo.getDb("test");
  let myobj = {
    path: req.path,
    protocol: req.protocol,
    method: req.method,
    httpVersion: req.httpVersion,
    ip: req.ip,
    hostname: req.hostname,
    startTime: req._startTime,
  };
  db_connect.collection("test").insertOne(myobj, function (err, res) {
    if (err) {
      logger.error(err);
      throw err;
    }
    logger.info("1 document added");
  });
  res.json({status:"added"})
});

module.exports = router;
