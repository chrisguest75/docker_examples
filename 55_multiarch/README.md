# README

Demonstrate building and running multi-arch images

QEMU example [here](https://github.com/chrisguest75/sysadmin_examples/tree/master/16_qemu)  

## TODO

* buildx builders
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
docker buildx build --platform linux/arm64 --target BASE -t chrisguest/ubuntu_arm64 -f ./Dockerfile.ubuntu .
docker run -it --rm chrisguest/ubuntu_arm64 
docker push chrisguest/ubuntu_arm64  

# build for amd64/x86
docker buildx build --platform linux/amd64 --target BASE -t chrisguest/ubuntu_amd64 -f ./Dockerfile.ubuntu .
docker run -it --rm chrisguest/ubuntu_amd64 
docker push chrisguest/ubuntu_amd64 

# build multi is not supported 
docker buildx build --platform linux/arm64,linux/amd64 --target BASE -t ubuntu_allarch -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_allarch
```

## Resources

* Docker Buildx [here](https://docs.docker.com/buildx/working-with-buildx/)
* Building Multi-Arch Images for Arm and x86 with Docker Desktop [here](https://www.docker.com/blog/multi-arch-images/)