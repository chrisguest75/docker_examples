# README.md
Demonstrate how to use Docker in Docker

TODO:
* Work out if I can use CAP_SYS rather than privilege
--cap-add=SYS_ADMIN /dev and /sys RO or RW

## Start container
It requires privilege to start Docker in Docker
```sh
# on the host create a dind  container
docker run -it --rm --privileged --entrypoint /bin/sh docker:20.10.7-dind
```

## Start daemon
```sh
# inside the container start docker daemon
docker-entrypoint.sh dockerd&

# show client/server version 
docker version

# full info
docker info
```

## Run DinD image
```sh
# this will be a new docker process with no processes
docker ps 

# no images
docker images

# pull a new image
docker pull ubuntu:20.04

# show images
docker images

# start a container inside the container
docker run --name testdind -it --entrypoint /bin/bash ubuntu:20.04

# exit and see it was started
docker ps -a
```

# Resources
* Repo for DinD [here](https://github.com/docker-library/docker)  
