# README
Demonstrate how to inject file into multiple running containers from host. 


## Walkthrough
List layers
```sh
sudo ls -l /var/lib/docker/overlay2
```

Clear out old images
```sh
docker rm $(docker ps -aq)
docker rmi $(docker images -aq)
docker volume ls
```

Pull an a single layer image
```sh
docker pull alpine:3.11.5

docker inspect image alpine:3.11.5

# layers added
sudo ls -l /var/lib/docker/overlay2

docker rmi alpine:3.11.5
# layers removed.
sudo ls -l /var/lib/docker/overlay2
```


# 4 layers
```sh
docker pull ubuntu:18.04

#Find the base layer directory
export BASELAYER=$(docker inspect ubuntu:18.04 | jq ".[].GraphDriver.Data.LowerDir | split(\":\")[-1]" --raw-output)

sudo ls -l ${BASELAYER}  
sudo ls -lR ${BASELAYER}/var/log

docker run -it --rm --entrypoint /bin/bash ubuntu:18.04
ls -l /var/log

sudo touch ${BASELAYER}/var/log/test.log
ls -l /var/log

```


