# README

Cheatsheet style helpers for common tasks.  

## ⚡️ Quick run

When you require a quick container to enter to perform some tests.  

```sh
# quick run a container to test something.
docker run -it --rm --name quicktest --entrypoint "/bin/bash" ubuntu:20.04   
```

## Compose

When you run using compose the container names will have prefixes.

```sh
# get the name of the docker container after being run through compose.    
SERVICENAME=redis
docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)"

# useful for inspect which doesn't exist in compose
SERVICENAME=nginx
docker inspect $(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)")
```

## Looking at image structure

You can either use [`dive`](../30_dive_ci/README.md) or use the ```--out``` parameter.

```bash
# write image to an ./out folder
docker build -f ./Dockerfile -t test -o out .
```

## 👀 Resources

* docker build [here](https://docs.docker.com/engine/reference/commandline/build/)  
