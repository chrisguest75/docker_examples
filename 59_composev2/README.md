# README

Demonstrate how to use docker compose v2.
Other examples using Compose:

* 44_reverse_proxy [README.md](./44_reverse_proxy/README.md)  
* 03_ffprobe [docker-compose.yaml](https://github.com/chrisguest75/mongo_examples/blob/main/03_ffprobe/docker-compose.yaml)
* 07_coredns_tcpdump [docker-compose.yaml]https://github.com/chrisguest75/sysadmin_examples/blob/master/07_coredns_tcpdump/docker-compose.yaml)

TODO:

* Env `--env-file ./compose.env` 
* Build `docker compose --env-file ./compose.env -f ./docker-compose-tests.yaml --profile backend build --force-rm --no-cache`


NOTES:

* `--ssh` is not supported on compose.  You have to build image seperately.
* Docker Compose V2 is a plugin.  This can be installed on `apt` using 
    `apt-get install -qq -y docker-compose-plugin`

## Build

```sh
# show the profiles
docker compose config --profiles  

# bring up profiles individually
docker compose --profile backend up -d --build
docker compose --profile frontend up -d --build

# bring both profiles down
docker compose --profile backend --profile frontend down

# bring up boh profiles with --build
docker compose --profile backend --profile frontend up -d --build --force-recreate 

# quick test of logs
docker logs $(docker ps --filter name=59_composev2-ubuntu-1 -q)
docker logs $(docker ps --filter name=59_composev2-nginx-1 -q)

# bring it down and delete the volume
docker-compose --profile backend down --volumes
```

## Resources

* Compose Spec Site [here](https://www.compose-spec.io/)
* The Compose Specification [here](https://github.com/compose-spec/compose-spec/blob/master/spec.md)