# README

Cheatsheet style helpers for common tasks.  

## Quick run

When you require a quick container to enter to perform some tests.  

```sh
# quick run a container to test something.
docker run -it --rm --name quicktest --entrypoint "/bin/bash" ubuntu:20.04   
```

## Compose

```sh
# get the name of the docker container after being run through compose.    
SERVICENAME=redis
docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)"
```

## 👀 Resources
