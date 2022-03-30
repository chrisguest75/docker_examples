# README

Cheatsheet style helpers for common tasks.

## Compose

```sh
# get the name of a container from a compose 
SERVICENAME=redis
docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)"
```

## Resources
