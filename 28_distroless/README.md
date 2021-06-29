# README
Demonstrate Distroless containers where the shell is removed. 

TODO:
1. Add the node12 changes.
1. 

## Build example 
```sh
# node10
docker build --no-cache -f v10.Dockerfile -t v10_distroless .
docker run -it --rm v10_distroless  

# node14
docker build --no-cache -f v14.Dockerfile -t v14_distroless .
docker run -it --rm v14_distroless  
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

## Docker Scan (vulnerability scanning) 
```sh
# scan v10
docker scan v10_distroless  

# scan v14
docker scan v14_distroless  

# scan debug
docker scan distroless-debug  
```

# Resources 
* Distroless repo [here](https://github.com/GoogleContainerTools/distroless)  
* Node build tags [here](https://github.com/GoogleContainerTools/distroless/blob/main/nodejs/README.md)  
* NodeJS bestpractices [here](https://snyk.io/wp-content/uploads/10-best-practices-to-containerize-Node.js-web-applications-with-Docker.pdf)  
