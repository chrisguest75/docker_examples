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
      if (err) throw err;
      console.log(result)
      res.render('index', { title: 'Express', result: result });
    });
});

module.exports = router;
