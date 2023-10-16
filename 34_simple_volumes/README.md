# README

Demonstrates using simple volumes.  

TODO:

* mount a volume during build and copy files to it to seed it.

## Reason

A useful demonstration of volume sharing for testing capabilties in pipelines.  

## Mount a file into a container

Execute a container and mount a file into it using the volume command.  

```sh
# create a running container
docker run -it -d -p 8080:80 --rm -v $(pwd)/index.html:/usr/share/nginx/html/index.html --name nginx nginx:1.23.3

# request the index
curl http://0.0.0.0:8080  
 
# clean up
docker stop nginx
```

## Resources

