# README

Demonstrate how to use docker compose v2.  

Other examples using Compose:

* 03_ffprobe [docker-compose.yaml](https://github.com/chrisguest75/mongo_examples/blob/main/03_ffprobe/docker-compose.yaml)
* 07_coredns_tcpdump [docker-compose.yaml]https://github.com/chrisguest75/sysadmin_examples/blob/master/07_coredns_tcpdump/docker-compose.yaml)
* 44_reverse_proxy [README.md](./44_reverse_proxy/README.md)  

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
docker compose --profile backend --profile frontend --profile timeout up -d --build --force-recreate 
```

## Running Containers

```sh
# output full object as json 
docker compose ps --format json | jq              

# show containers
docker compose ps 

# show service names only 
docker compose --profile all ps --services  
```

## Check running status

Status can be defined as one of created, restarting, running, removing, paused, exited, or dead  

```sh
# has a container exited?
docker compose ps --status exited --services | grep "timeout"

# a function to detect if a container is running or not
function has_container_exited() {
    local service=$1
    docker compose ps --format json | jq -e --arg service "$service" -r '.[] | select(.Service==$service and .State=="exited")' > /dev/null
    local exitcode=$?
    if [[ $exitcode == 0 ]]; then
        echo "$1 has exited"
        return 1
    else
        echo "$1 has not exited"
        return 0
    fi
}
has_container_exited "timeout"; echo $?
has_container_exited "nginx"; echo $?
has_container_exited "ubuntu"; echo $?
has_container_exited "doesnotexist"; echo $?
```

### Exec into running containers

```sh
# exec into container and run a process
docker compose exec ubuntu ls -la /
docker compose exec -it ubuntu ls -la /   
docker compose exec -it ubuntu ls -la /root  

# create a file in containers
docker compose exec -it ubuntu touch /root/test.txt

# check file existence
docker compose exec -it ubuntu bash -c "[[ -f /root/test.txt ]] && echo 'This file exists!'"
docker compose exec -it ubuntu bash -c "[[ -f /root/test.txt ]] && exit 1"
echo "$? exitcode"

# shell into container
docker compose exec -it ubuntu bash      
```

## Logs

```sh
# quick test of logs
docker compose logs ubuntu
docker compose logs nginx
docker compose logs timeout
```

## Cleanup

```sh
# bring it down and delete the volume
docker-compose --profile all down --volumes
```

## Resources

* Compose Spec Site [here](https://www.compose-spec.io/)
* The Compose Specification [here](https://github.com/compose-spec/compose-spec/blob/master/spec.md)
* docker ps [here](https://docs.docker.com/engine/reference/commandline/ps/)
