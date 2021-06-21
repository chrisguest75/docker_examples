# README
Demonstrate some examples of using `docker scan`.

TODO:
1) use jq to aggregate
    * Counts
    * High sev.
    * Generate a report.  
1) Fix an image.

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

## Load data into mongo for aggregation

```sh
docker compose up -d
docker exec -it $(docker ps --filter name=45_docker_scan_client_1 -q) /bin/sh  

docker exec -it $(docker ps --filter name=45_docker_scan_mongodb_1 -q) /bin/sh  
mongo -u root -p rootpassword
use scans
db.scans.save({test:"test"})
db.scans.find()

cat ./scans/nginx1_21_0.json | jq .vulnerabilities | less
cat ./scans/nginx1_21_0.json | jq .vulnerabilities > ./scans/nginx1_21_0_array.json

mongoimport -u root -p rootpassword --port 27017 --db scans --collection example --type json --file /scans/nginx1_21_0_array.json --jsonArray



https://stackoverflow.com/questions/19441228/insert-json-file-into-mongodb/19441357

https://hub.docker.com/_/mongo?tab=description&page=1&ordering=last_updated

docker compose down     
```



## Processing with JQ
```sh
docker scan --json ubuntu:18.04 | jq   
docker scan --json --group-issues ubuntu:16.04 | jq -r '.vulnerabilities[] | [.title, .severity]'
```

# Resources 
https://dev.to/sonyarianto/how-to-spin-mongodb-server-with-docker-and-docker-compose-2lef
