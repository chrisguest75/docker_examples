# README
Demonstrates how to configure an image that can be mounted as a volume into a container. 

This is useful in CI pipelines where you need to share a file into a prebuilt container but don't have permissions to mount a volume.  

## Example
Docker volume mounting using a docker volume
```sh
docker create -v /usr/share/nginx/html --name content alpine:3.4 /bin/true
docker cp index.html content:/usr/share/nginx/html
docker run --rm --volumes-from content -p 8080:80 -it --name nginxvolume nginx:1.19.9 

curl http://localhost:8080
open http://localhost:8080
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
# list volumes
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