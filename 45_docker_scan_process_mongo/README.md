# DOCKER SCAN

![maintenance-status](https://img.shields.io/badge/maintenance-deprecated-red.svg)  

Demonstrate some examples of using `docker scan`.

Docker scan works with public and private images

For reducing number of vulnerabilities refer to:

* Distroless [README.md](../28_distroless/README.md)  
* Nix [README.md](https://github.com/chrisguest75/nix-examples/blob/master/README.md)  

## Alternative Scanners

* Grype [README.md](../49_grype/README.md)  
* Trivy [README.md](../48_trivy/README.md)  
* Docker Scout [README.md](../A1_docker_scout/README.md)  

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
mkdir -p ./scans/docker
docker scan --json nginx:1.21.0 > ./scans/docker/nginx1_21_0.json  
```

## Script to scan many and create report

```sh
# scan images listed in `images_to_scan.json`
./scan.sh

# open index.html in vscode and open live server
```

## Load data into MongoDB for aggregation

Query the data (gui)

```sh
https://robomongo.org/
brew install robo-3t

connect to localhost:27017
```

```sh
# process the vulnerabilities
cat ./scans/docker/nginx1_21_0.json | jq .vulnerabilities | less
cat ./scans/docker/nginx1_21_0.json | jq .vulnerabilities > ./scans/docker/nginx1_21_0_array.json

# start mongo server
docker compose up -d

# exec into db
docker exec -it $(docker ps --filter name=45_docker_scan_process_mongo_mongodb_1 -q) /bin/bash

# import vulnerabilities
mongoimport --username=root --password=rootpassword --host 0.0.0.0 --type json --db images --collection=scans --file /scans/docker/alpine_3.14.json --authenticationDatabase admin

mongoimport --username=root --password=rootpassword --host 0.0.0.0 --type json --db images --collection=scans --file /scans/docker/nginx_1.21.0.json --authenticationDatabase admin

mongoimport --username=root --password=rootpassword --host 0.0.0.0 --type json --db images --collection=scans --file /scans/docker/node_lts-alpine3.13.json --authenticationDatabase admin

mongoimport --username=root --password=rootpassword --host 0.0.0.0 -
-type json --db images --collection=scans --file /scans/docker/ubuntu_20.04.json --authenticationDatabase admin
```

## Query the data (cli)

```sh
mongo -u root -p rootpassword
use images
show collections
db.scans.find()
```

## Example queries

```js
// count images matching
db.getCollection('scans').find({path: 'ubuntu:20.04'}).count()

// only matches on if we have high severity in array
db.getCollection('scans').find({path: 'ubuntu:20.04', vulnerabilities: { $elemMatch: { severity: 'high'}}})

// return all vulnerabilities
db.getCollection('scans').find({path: 'ubuntu:20.04'}, {id: 1, title: 1, vulnerabilities:1})

// filter out sev, cvss, title.
db.getCollection('scans').find({path: 'ubuntu:20.04'}, {id: 1, title: 1, vulnerabilities: {severity:1, title:1, CVSSv3:1, identifiers: {CVE:1},packageName: 1,from: 1}})

// get distinct vulnerabilities across all images
db.getCollection('scans').distinct("vulnerabilities.id")

// distinct id on a particular image
db.getCollection('scans').distinct("vulnerabilities.id", {path: 'ubuntu:20.04'})
```

## Aggregations

```js
// total number of vulnerabilities
db.getCollection('scans').aggregate([{$project: { count: { $size:"$vulnerabilities" }}}])

// vulnerability counts by severity
db.getCollection('scans').aggregate([
  {$match: {path: 'nginx:1.21.0'} },
  {$project: { _id: 0, vulnerabilities: { severity:1 }} }
  ,{ $unwind : '$vulnerabilities' }
  ,{ $sort : { "vulnerabilities.severity" : 1 } }
  ,{ $group : { _id : "$vulnerabilities.severity", severity: { $push: "$vulnerabilities.severity" } } }
  ,{$project: { _id:0, severity: "$_id", count: { $size: "$severity"}} }
])

// list all vulnerability urls
db.getCollection('scans').aggregate([
   {$match: {path: 'ubuntu:20.04'} }
   ,{ $unwind : '$vulnerabilities' }
   ,{ $project: { _id:0, url: { $concat: [ "https://snyk.io/vuln/", "$vulnerabilities.id"] } } }
   ,{ $group: { _id:0, url:{$push:"$url"} } }
])

// group urls by severity
db.getCollection('scans').aggregate([
   {$match: {path: 'ubuntu:20.04'} }
   ,{ $unwind : '$vulnerabilities' }
   ,{ $project: { _id:0, severity: "$vulnerabilities.severity", url: { $concat: [ "https://snyk.io/vuln/", "$vulnerabilities.id"] } } }
   ,{ $group : { _id : "$severity", severity: { $push: "$url"  } } }  
])
```

## Full report

```js
// *** not sure how to aggregate severity array. ***
db.getCollection('scans').aggregate([
  {$project: { _id: 0, image: "$path", severity:"$vulnerabilities.severity" } }
  ,{ $addFields: { imagepath: "$image" }}
])
```


## Cleanup

```sh
docker compose down     
```

## Processing with JQ (this is done automatically by `scan.sh`)

```sh
mkdir -p ./out
# pull all images (docker scan) into a single json document
./aggregate.sh | jq -s '{images: (.)}' > ./out/images.json  
```

## Liveserver in vscode

Use the live share extension.  

The example uses a `./scans/out/images_docker.json` file that has to be served up from a webserver.  

```sh
# use a live server to server up pages that have resources
code --install-extension ritwickdey.LiveServer
```

## 👀 Resources

* MongoDB manual [here](https://docs.mongodb.com/manual)  
* MongoDB in Compose [here](https://dev.to/sonyarianto/how-to-spin-mongodb-server-with-docker-and-docker-compose-2lef)
* MongoDB in Dockerhub [here](https://hub.docker.com/_/mongo)
* Use `cheatsheet mongo+find`
* aggregation-pipeline docs [here](https://docs.mongodb.com/manual/core/aggregation-pipeline/)  
* MongoDB groupby [here](https://stackoverflow.com/questions/21509045/mongodb-group-by-array-inner-elements)
* aggregation-at-each-document-level-mongodb [here](https://stackoverflow.com/questions/59017042/aggregation-at-each-document-level-mongodb)  
