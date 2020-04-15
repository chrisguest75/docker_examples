# README
Demonstrate Distroless containers where the shell is removed. 

TODO:
1. Add the node12 changes.

## Build example 
```sh
docker build --no-cache -f Dockerfile -t distroless .
docker run -it --rm distroless  
```

## Build debug example 
```sh
docker build --no-cache -f debug.Dockerfile -t distroless-debug .
docker run -it --rm distroless-debug  

# Get onto the container
docker run -it --rm --entrypoint /busybox/sh distroless-debug
```

## Upgrade to Node12
```sh
docker build --no-cache -f distroless_node12.Dockerfile -t distroless-build .

docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm distroless-build  
```

Debug  
```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm --entrypoint /bin/bash distroless-build  

# Run this inside the container
bazel run //experimental/nodejs --verbose_failures --sandbox_debug  
```