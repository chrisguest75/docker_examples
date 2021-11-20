# README

Demonstrate building and running multi-arch images

## TODO 
* buildx builders 
* run the container on a raspberrypi  
* build for graviton?


Supported architectures

```sh
docker buildx ls   
```

## Build

```sh
docker build --target BASE -t ubuntu_x86 -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_x86 



docker buildx build --platform linux/arm64 --target BASE -t ubuntu_arm64 -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_arm64 




docker buildx build --platform linux/arm64,linux/amd64 --target BASE -t ubuntu_allarch -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_allarch
```


## Resources 
https://www.docker.com/blog/multi-arch-images/