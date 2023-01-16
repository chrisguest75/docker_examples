# README

Demonstrates using simple volumes.

## Reason

A useful demonstration of volume sharing for testing capabilties in pipelines.  

## Example - Running Containers

Execute a container and copy bash out if it.  

```sh
# create a running container
docker run -it -d -p 8080:80 --rm -v $(pwd)/index.html:/usr/share/nginx/html/index.html --name nginx nginx:1.23.3

# clean up
docker stop nginx
```

## Resources

