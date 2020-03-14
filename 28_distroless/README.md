# README
Demonstrate Distroless containers where the shell is removed. 

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

