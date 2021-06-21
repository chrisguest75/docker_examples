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

## Processing with JQ
```sh
docker scan --json ubuntu:18.04 | jq   
docker scan --json --group-issues ubuntu:16.04 | jq -r '.vulnerabilities[] | [.title, .severity]'
```

