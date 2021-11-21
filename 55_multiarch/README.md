# README

Demonstrate building and running multi-arch images

## TODO 
* buildx builders 
* run the container on a raspberrypi  
* qemu
* build for graviton?


Supported architectures

```sh
# list the supported platforms
docker buildx ls   
```

## Build

```sh
# build using docker defaults
docker build --target BASE -t ubuntu_default -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_default 

# build for arm64
docker buildx build --platform linux/arm64 --target BASE -t ubuntu_arm64 -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_arm64 

# build for amd64/x86
docker buildx build --platform linux/amd64 --target BASE -t ubuntu_amd64 -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_amd64 

# build multi is not supported 
docker buildx build --platform linux/arm64,linux/amd64 --target BASE -t ubuntu_allarch -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_allarch
```


## Resources 
https://docs.docker.com/buildx/working-with-buildx/
https://www.docker.com/blog/multi-arch-images/