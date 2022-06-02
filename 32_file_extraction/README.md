# README

Demonstrates copying data out of container images.

## ➡ Example

Go through a few examples of how to extract binaries from built containers.  

ℹ NOTE: You do not have to name the container.  The id will also work.  

Create a container and copy bash out of it

```sh
# create a container
docker create --name bash bash:5.0.7
# copy file from container
docker cp bash:/usr/local/bin/bash .
# clean up
docker rm bash
```

Execute a container and copy bash out if it.  

```sh
# create a running container
docker run -it -d --rm --name bash --entrypoint /usr/local/bin/bash bash:5.0.7
# copy file from container
docker cp bash:/usr/local/bin/bash .
# clean up
docker stop bash
```
