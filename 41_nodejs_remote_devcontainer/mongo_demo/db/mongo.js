const { MongoClient } = require("mongodb");
const db_uri = process.env.MONGO_URI;
const db_name = process.env.MONGO_DB_NAME;
const client = new MongoClient(db_uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
 
var _db;
 
module.exports = {
  connectToServer: function (callback) {
    console.log("Attempt to connect to MongoDB.");
    client.connect(function (err, db) {
      // Verify we got a good "db" object
      if (db)
      {
        _db = db.db(db_name);
        console.log("Successfully connected to MongoDB."); 
      }
      return callback(err);
         });
  },
 
  getDb: function () {
    return _db;
  },
};