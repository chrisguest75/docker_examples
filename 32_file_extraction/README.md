# README
Demonstrates copying data out of container images.

## Example
Go through a few examples of how to extract binaries from built containers.  

You do not have to name the container.  The id will also work. 

Create a container and copy bash out of it
```sh
docker create --name bash bash:5.0.7
docker cp bash:/usr/local/bin/bash .
docker rm bash
```

Execute a container and copy bash out if it. 
```sh
docker run -it -d --rm --name bash --entrypoint /usr/local/bin/bash bash:5.0.7
docker cp bash:/usr/local/bin/bash .
docker stop bash
```


