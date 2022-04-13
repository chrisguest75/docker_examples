# README

Cheatsheet style helpers for common tasks.

## Quick run

```sh
# quick run a container to test something.
docker run -it --rm --name quicktest --entrypoint "/bin/bash" ubuntu:20.04   
```

## Compose

```sh
# get the name of a container from a compose 
SERVICENAME=redis
docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)"
```

## Resources
