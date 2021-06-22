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
# process the vulnerabilities
cat ./scans/nginx1_21_0.json | jq .vulnerabilities | less
cat ./scans/nginx1_21_0.json | jq .vulnerabilities > ./scans/nginx1_21_0_array.json

# start mongo server
docker compose up -d

# exec into db
docker exec -it $(docker ps --filter name=45_docker_scan_mongodb_1 -q) /bin/bash  

# import vulnerabilities
mongoimport --username=root --password=rootpassword --host 0.0.0.0 --type json --file /scans/nginx1_21_0_array.json --jsonArray  --authenticationDatabase admin
```

## Query the data
```sh
mongo -u root -p rootpassword
use test
show collections
db.nginx1_21_0_array.find()
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
