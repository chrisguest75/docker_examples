# README
Demonstrate how to inject file into multiple running containers from host. 

**NOTE this needs to be run through on Linux** 

## Walkthrough
List layers that exist on the machine
```sh
sudo ls -l /var/lib/docker/overlay2
```

Clear out old images and layers
```sh
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)
docker volume ls

# Directory should be empty now.
sudo ls -l /var/lib/docker/overlay2
```

## Single layer image
Pull an a single layer image
```sh
docker pull alpine:3.11.5

docker inspect alpine:3.11.5

# List layers added
sudo ls -l /var/lib/docker/overlay2

docker rmi alpine:3.11.5
# Layers removed again.
sudo ls -l /var/lib/docker/overlay2
```

# Multiple layer image
```sh
docker pull ubuntu:18.04

# Find the base layer directory
export BASELAYER=$(docker inspect ubuntu:18.04 | jq ".[].GraphDriver.Data.LowerDir | split(\":\")[-1]" --raw-output)

# Show rootfs for ubuntu 
sudo ls -l ${BASELAYER}  

# Show rootfs log folders for ubuntu 
sudo ls -lR ${BASELAYER}/var/log

# Log onto the container and show log folder
docker run -it --rm --entrypoint /bin/bash ubuntu:18.04
ls -l /var/log

# On the host in seperate shell inject a file
sudo touch ${BASELAYER}/var/log/test.log

# Back in container shell see that test.log now exsits
ls -l /var/log

```


