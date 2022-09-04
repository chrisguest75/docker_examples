# README

Demonstrate how to use docker compose scale.  

ℹ️ NOTES:

* When scaling out the pods docker seems to round robin for each of the pods.  

## 🏠 Start

```sh
# start with overrides and shared port (this will not work)
docker compose up -d --scale podinfo=3      

# exposing is meant to pick random ports for containers (not working)
docker compose -f docker-compose.yaml -f docker-compose.expose.yaml up -d --scale podinfo=3   
docker compose ps
curl 0.0.0.0:9898 

# start without overrides (but port is not open)
docker compose -f docker-compose.yaml up -d --scale podinfo=3   
```

### Exec into running containers

```sh
# see the environment variables passed in
docker compose exec -it ubuntu /bin/bash

# install curl
apt update
apt install curl 

# see how it round robins.
curl podinfo:9898
```

## 🧼 Cleanup

```sh
# bring it down and delete the volume
docker compose down --volumes
```

## 👀 Resources

* How to Use Docker Compose to Run Multiple Instances of a Service in Development [here](https://pspdfkit.com/blog/2018/how-to-use-docker-compose-to-run-multiple-instances-of-a-service-in-development/)  

