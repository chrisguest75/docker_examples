# README

Demonstrate how to use docker compose to compose multiple services

Other examples using Compose:

* 59_composev2 [README.md](../59_composev2/README.md)  

Demonstrates:

* `docker-compose.yaml` default overrides
* Multiple compose files
* Merging definitions

## Build & Run (default overrides)

Default overrides `docker-compose.override.yaml`.

```sh
# with a file name it will automatically use a file called `docker-compose.override.yaml`
# injects a service 
docker compose --profile all up -d --build --force-recreate

# test the nginx service version 1.21.6
curl -vvv 0.0.0.0:8080
curl -vvv 0.0.0.0:8081
docker compose logs nginx
docker compose logs nginx2

# inspect how the environment variables were overridden
docker inspect $(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps nginx -q)")

# cleanup
docker compose --profile all down             
```

## Build & Run (specify file)

Specifiy a `docker-compose.yaml` file

```sh
# with a file name it does not automatically use overrides
docker compose -f ./docker-compose.yaml --profile all up -d --build --force-recreate

# test the nginx service version 1.20.1
curl -vvv 0.0.0.0:8080
docker compose logs nginx

# cleanup
docker compose -f ./docker-compose.yaml --profile all down             
```

## Build & Run (manually specify file)

Manually specifiy a `docker-compose.override.yaml` file

```sh
# with a file name it does not automatically use overrides
docker compose -f ./docker-compose.yaml -f ./docker-compose.override.yaml --profile all up -d --build --force-recreate

# test the nginx service version 1.20.1
curl -vvv 0.0.0.0:8080
curl -vvv 0.0.0.0:8081
docker compose logs nginx
docker compose logs nginx2


# cleanup
docker compose -f ./docker-compose.yaml -f ./docker-compose.override.yaml --profile all down             
```

## Build & Run (merge all three files)

Merge all three files  

```sh
# with a file name it does not automatically use overrides
docker compose -f ./docker-compose.yaml -f ./docker-compose.override.yaml -f ./docker-compose.nginx3.yaml --profile all up -d --build --force-recreate

# test the nginx service version 1.20.1
curl -vvv 0.0.0.0:8080
curl -vvv 0.0.0.0:8081
curl -vvv 0.0.0.0:8082
docker compose logs nginx
docker compose logs nginx2
docker compose logs nginx3

# cleanup
docker compose -f ./docker-compose.yaml -f ./docker-compose.override.yaml -f ./docker-compose.nginx3.yaml --profile all down
```

## Resources

* Compose Spec Site [here](https://www.compose-spec.io/)
* The Compose Specification [here](https://github.com/compose-spec/compose-spec/blob/master/spec.md)
* docker ps [here](https://docs.docker.com/engine/reference/commandline/ps/)
