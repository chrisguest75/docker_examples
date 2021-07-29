let error = false

let res = [
  db.test.drop(),
  db.createUser(
    {
      user: "user",
      pwd: "userpassword",
      roles: [ { role: "readWrite", db: "test" } ]
    }
  ),  
  //db.test.createIndex({ id: 1 }, { unique: true }),
  db.test.insert({ id: 1, value: 'hello' }),
]

printjson(res)


if (error) {
  print('Error occured during initialisation')
  quit(1)
}