# README
Demonstrate some examples of using `docker scan`.

Docker scan works with public and private images

TODO:
1) use jq to aggregate
    * Counts
    * High sev.
    * Generate a report.  
1) Fix an image.

## Scanning
```sh
# show options
docker scan

# you may need to auth with snyk to get scans
docker scan --login 
```

## Simple scans
```sh
# pull is unnecessary 
docker scan ubuntu:18.04    
docker scan ubuntu:20.04 

# 122 vulnerabilities 😲
docker scan nginx:1.20.1    

# 5 vulnerabilities
docker scan nginx:1.21.0-alpine    
```

## Export JSON
```sh
mkdir -p ./scans
docker scan --json nginx:1.21.0 > ./scans/nginx1_21_0.json  
```

## Load data into MongoDB for aggregation
```sh
# process the vulnerabilities
cat ./scans/nginx1_21_0.json | jq .vulnerabilities | less
cat ./scans/nginx1_21_0.json | jq .vulnerabilities > ./scans/nginx1_21_0_array.json

# start mongo server
docker compose up -d

# exec into db
docker exec -it $(docker ps --filter name=45_docker_scan_process_mongo_mongodb_1 -q) /bin/bash

# import vulnerabilities
mongoimport --username=root --password=rootpassword --host 0.0.0.0 --type json --file /scans/nginx1_21_0_array.json --jsonArray  --authenticationDatabase admin
```

## Query the data (cli)
```sh
mongo -u root -p rootpassword
use test
show collections
db.nginx1_21_0_array.find()
```

## Query the data (gui)
```sh
https://robomongo.org/
brew install robo-3t

connect to localhost:27017
```

## Example queries
```js
// count high and low
db.getCollection('nginx1_21_0_array').find({severity: 'high'}).count()
db.getCollection('nginx1_21_0_array').find({severity: 'low'}).count()

// return groups
db.getCollection('nginx1_21_0_array').find({}, {id: 1, title: 1, packageName: 1, severity: 1, from: 1, description: 1})

// how many distinct ids are there?
db.getCollection('nginx1_21_0_array').distinct("id")

// make into urls
db.getCollection('nginx1_21_0_array').aggregate(
   [
      { $project: { url: { $concat: [ "https://snyk.io/vuln/", "$id" ] } } }
   ]
)
```

## Cleanup 
```sh
docker compose down     
```

## Processing with JQ
```sh
docker scan --json ubuntu:18.04 | jq   
docker scan --json --group-issues ubuntu:16.04 | jq -r '.vulnerabilities[] | [.title, .severity]'
```

# Resources 
https://dev.to/sonyarianto/how-to-spin-mongodb-server-with-docker-and-docker-compose-2lef
https://hub.docker.com/_/mongo
cheatsheet mongo+find