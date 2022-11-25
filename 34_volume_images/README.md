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

# inspect and find mountpoint
docker volume inspect 67e772ddc94278d6560894b79e9b6c070197f1a3f826510de4cc749644b6b49

# enter host container (on macosx)
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh

# list the contents of the volume
ls "/var/lib/docker/volumes/67e772ddc94278d6560894b79e9b6c070197f1a3f826510de4cc749644b6b497/_data"
```

## 🧼 Cleanup

```sh
# kill all
docker system prune --all 
```

## 👀 Resources

* docker volume create [here](https://docs.docker.com/engine/reference/commandline/volume_create/)
* Mount a Volume to a Container [here](https://earthly.dev/blog/docker-volumes/#mount-a-volume-to-a-container)
* How to Compose Projects Using Docker-Compose [here](https://www.freecodecamp.org/news/the-docker-handbook/#how-to-compose-projects-using-docker-compose)
