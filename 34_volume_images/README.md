# README

Demonstrates how to configure an `image` that can be mounted as a volume into a container.  

## Reason

This is useful in CI pipelines where you need to share a file into a prebuilt container but don't have permissions to mount a volume.  Or the docker socket has been shared in and the internal containers paths cannot be seen by the host.  

Other compose examples [59_composev2/README.md](59_composev2/README.md)  

📝 TODO:

* Test volume container with multiple volumes.

## 🏠 Build

Docker volume mounting using a docker `volume_from`  

```sh
# creates a container that can be used as a volume
docker create -v /usr/share/nginx/html -v /code --name content alpine:3.4 /bin/true

# ERROR: not possible to exec into the container as it is not running
docker exec -it content /bin/sh  

# inspect the container
docker inspect content

# copy a single file and directory into the volume
docker cp index.html content:/usr/share/nginx/html
docker cp ../ content:/code 

# run the container using volume
docker run -d --rm --volumes-from content -p 8080:80 -it --name nginxvolumetest nginx:1.21.1 

# show logs 
docker logs nginxvolumetest

# get page
curl http://localhost:8080
open http://localhost:8080

# show files in volume
docker exec -it nginxvolumetest ls /usr/share/nginx/html
docker exec -it nginxvolumetest ls -lR /code

# in another shell (copy file into live volume)
docker cp helloworld.txt content:/usr/share/nginx/html

# see file is copied into live volume
docker exec -it nginxvolumetest ls /usr/share/nginx/html

# shutdown container
docker stop nginxvolumetest

# shutdown volume container
docker stop content 
```

## Use compose

Docker compose volume mounting using a docker `volume_from`  

```sh
# start up (this works)
docker compose --profile all up -d 

# bring up code only (can do this but next step doesn't work)
docker compose --profile all up -d code  
# NOTE: This does not seem to work (meaning you cannot bring up a container later)
docker compose --profile all up -d code nginx
```

### Use compose commands

Depends on step above to start services.  

```sh
# show no page exists
open http://localhost:8080

# copy content
docker compose cp index.html code:/usr/share/nginx/html
docker compose cp ../ code:/code 

#docker compose --profile frontend up -d nginx

# show logs
docker compose --profile all logs nginx  

# get page
curl http://localhost:8080
open http://localhost:8080

# show files in volume
docker compose --profile all exec -it nginx ls /usr/share/nginx/html
docker compose --profile all exec -it nginx ls -lR /code

# in another shell (copy file into live volume)
docker compose --profile all cp helloworld.txt code:/usr/share/nginx/html

# see file is copied into live volume
docker compose --profile all exec -it nginx ls /usr/share/nginx/html

```

### Use docker commands against compose started containers

```sh
CODECONTAINER=$(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose --profile all ps code -q)")  
NGINXCONTAINER=$(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose --profile all ps nginx -q)")  
echo $CODECONTAINER
echo $NGINXCONTAINER
docker cp index.html $CODECONTAINER:/usr/share/nginx/html
docker cp ../ $CODECONTAINER:/code 

# show logs 
docker logs $NGINXCONTAINER

# get page
curl http://localhost:8080
open http://localhost:8080

# show files in volume
docker exec -it $NGINXCONTAINER ls /usr/share/nginx/html
docker exec -it $NGINXCONTAINER ls -lR /code

# in another shell (copy file into live volume)
docker cp helloworld.txt $CODECONTAINER:/usr/share/nginx/html

# see file is copied into live volume
docker exec -it $NGINXCONTAINER ls /usr/share/nginx/html
```

### Docker down

Cleanup all the compose containers.  

```sh
docker compose --profile all down     
```

## 🔍 Inspect

```sh
# list volumes (it's not listed as a volume)
docker volume ls    

# inspect and find mountpoint (volumne_name or anonymous id guid)
docker volume inspect volume_name

# enter host container (on macosx)
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh

# list the contents of the volume
ls "/var/lib/docker/volumes/volume_name/_data"
```

## Create and copy files into a volume

Execute a container and copy bash out if it.  

```sh
# NOTE: This still needs to be available to host path (devcontainer challenge)
docker run --rm -v $PWD:/source -v my_volume_name:/dest -w /source alpine cp index.html /dest

# list files in a volume
docker run -it --rm -v my_volume_name:/dest -it --name volumetest ubuntu:22.04 /bin/bash -c "ls -la /dest" 
```

## Pipe files into a volume generically

If you're running docker outside docker (in a devcontainer). You'll find it difficult to mount paths into the containers when running them. This is because the mount path will need to be provided for the host.
A work around for this is to pipefile into a volume using a container. You can then use the volume as a mount.  

```sh
# create a volume
docker volume create 34_test_piping_into_volume

docker volume ls

# test locally 
cat ./README.md | ./pipeable.sh --pipe --target=./test.txt
cat ./README.md | ./pipeable.sh --debug --list --target=./  

# build the container to pipe to volume
docker build -f Dockerfile.pipeable -t default_pipeable .

# pipe a binary file into the volume
cat Dockerfile.pipeable | docker run -i -v 34_test_piping_into_volume:/myvolume default_pipeable --pipe --target=/myvolume/test.txt

# list volume contents
cat Dockerfile.pipeable | docker run -i -v 34_test_piping_into_volume:/myvolume default_pipeable --list --target=/myvolume

# show contents on the volume
cat Dockerfile.pipeable | docker run -i -v 34_test_piping_into_volume:/myvolume default_pipeable --show --target=/myvolume/test.txt

# file md5 on the volume
cat Dockerfile.pipeable | docker run -i -v 34_test_piping_into_volume:/myvolume default_pipeable --md5 --target=/myvolume/test.txt

```

## 🧼 Cleanup

```sh
# kill all
docker system prune --all 
```

## 👀 Resources

* docker Volumes docs [here](https://docs.docker.com/storage/volumes/)
* docker volume create [here](https://docs.docker.com/engine/reference/commandline/volume_create/)
* Mount a Volume to a Container [here](https://earthly.dev/blog/docker-volumes/#mount-a-volume-to-a-container)
* How to Compose Projects Using Docker-Compose [here](https://www.freecodecamp.org/news/the-docker-handbook/#how-to-compose-projects-using-docker-compose)
* Copy a file inside a docker volume with a one-liner! [here](https://levelup.gitconnected.com/copy-a-file-inside-a-docker-volume-with-a-one-liner-e6fb71e2e4ae)
* How can I handle raw binary data in a bash pipe? [here](https://unix.stackexchange.com/questions/19043/how-can-i-handle-raw-binary-data-in-a-bash-pipe)  
