# README

Demonstrates using simple volumes.  

NOTES:

* You cannot map an individual file from a volume into a container.  
* AFAICS - You cannot mount a volume during build and copy files to it to seed it - maybe using VOLUME you can.

## Reason

A useful demonstration of volume sharing for testing capabilties in pipelines.  

## Mount a file into a container from local

Execute a container and mount a file into it using the volume command.  

```sh
# create a running container (basic volume syntax)
docker run -it -d -p 8080:80 --rm -v $(pwd)/index.html:/usr/share/nginx/html/index.html --name nginx nginx:1.23.3

# use bind mount syntax for file share
docker run -it -d -p 8080:80 --rm --mount "type=bind,src=$(pwd)/index.html,dst=/usr/share/nginx/html/index.html" --name nginx nginx:1.23.3

# request the index
curl http://0.0.0.0:8080  

# use bind mount syntax for file share read-only
docker run -it -d -p 8080:80 --rm --mount "type=bind,src=$(pwd)/index.html,dst=/usr/share/nginx/html/index.html,readonly" --name nginx nginx:1.23.3

# test read-only 
docker exec -it nginx /bin/bash  
echo "test" > /usr/share/nginx/html/index.html 

# clean up
docker stop nginx
```

## Resources

* Bind mounts docs [here](https://docs.docker.com/storage/bind-mounts/)
* Volumes docs [here](https://docs.docker.com/storage/volumes/)
