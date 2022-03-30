# README

Demonstrates how to configure an `image` that can be mounted as a volume into a container.  

This is useful in CI pipelines where you need to share a file into a prebuilt container but don't have permissions to mount a volume.  

TODO:

* Test volume container with multiple volumes.

## Example

Docker volume mounting using a docker volume  

```sh
# creates a container that can be used as a volume
docker create -v /usr/share/nginx/html --name content alpine:3.4 /bin/true

# not possible to exec into the container as it is not running
docker exec -it content /bin/sh  

# inspect the container
docker inspect content              

# copy a single file into the volume
docker cp index.html content:/usr/share/nginx/html

# run the container
docker run -d --rm --volumes-from content -p 8080:80 -it --name nginxvolumetest nginx:1.19.9 

# show logs 
docker logs nginxvolumetest

# get page
curl http://localhost:8080
open http://localhost:8080

# show files in volume
docker exec -it nginxvolumetest ls /usr/share/nginx/html

# in another shell (copy file into live volume)
docker cp helloworld.txt content:/usr/share/nginx/html

docker exec -it nginxvolumetest ls /usr/share/nginx/html

# shutdown container
docker stop nginxvolumetest
```

## Edit and reload

```sh
# edit index.html and copy it again. 
docker cp index.html content:/usr/share/nginx/html
docker run --rm --volumes-from content -p 8080:80 -it --name nginxvolume nginx:1.19.9 

open http://localhost:8080
```

## Inspect

```sh
# list volumes (it's listed as a volume)
docker volume ls    

# inspect and find mountpoint
docker volume inspect 67e772ddc94278d6560894b79e9b6c070197f1a3f826510de4cc749644b6b49

# enter host container (on macosx)
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh

# list the contents of the volume
ls "/var/lib/docker/volumes/67e772ddc94278d6560894b79e9b6c070197f1a3f826510de4cc749644b6b497/_data"
```

## Cleanup

```sh
# kill all
docker system prune --all 
```

## Resources

* docker volume create [here](https://docs.docker.com/engine/reference/commandline/volume_create/)