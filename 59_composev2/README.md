# README

Demonstrate how to use docker compose v2.
Other examples using Compose:

* 44_reverse_proxy [README.md](./44_reverse_proxy/README.md)  
* 03_ffprobe [docker-compose.yaml](https://github.com/chrisguest75/mongo_examples/blob/main/03_ffprobe/docker-compose.yaml)
* 07_coredns_tcpdump [docker-compose.yaml]https://github.com/chrisguest75/sysadmin_examples/blob/master/07_coredns_tcpdump/docker-compose.yaml)

Demonstrates:

* Building and naming images
* Networks

TODO:

* Env `--env-file ./compose.env` 
* Build `docker compose --env-file ./compose.env -f ./docker-compose-tests.yaml --profile backend build --force-rm --no-cache`
* https://docs.docker.com/compose/extends/

NOTES:

* `--ssh` is not supported on compose.  You have to build image seperately.
* Docker Compose V2 is a plugin.  This can be installed on `apt` using 
    `apt-get install -qq -y docker-compose-plugin`

## Build & Run

```sh
# show the profiles
docker compose config --profiles  

# NOTE: It seems you need to purge the cache as force-recreate uses cached layers.
docker builder prune 
docker system prune --all --force 

# bring up all profiles
docker compose --profile all ps  

# bring up profiles individually
docker compose --profile backend up -d --build --force-recreate
docker compose --profile frontend up -d --build --force-recreate
docker compose --profile timeout up -d --build --force-recreate

# bring both profiles down
docker compose --profile backend --profile frontend down

# bring up both profiles with --build
docker compose --profile backend --profile frontend --profile frontend timeout -d --build --force-recreate 
```

## Logs

```sh
# quick test of logs
docker compose logs 59_composev2-ubuntu
docker compose logs 59_composev2-nginx
docker compose logs 59_composev2-timeout
```

## Cleanup

```sh
# bring it down and delete the volume
docker-compose --profile all down --volumes
```

## Resources

* Compose Spec Site [here](https://www.compose-spec.io/)
* The Compose Specification [here](https://github.com/compose-spec/compose-spec/blob/master/spec.md)