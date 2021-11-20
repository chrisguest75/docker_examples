# README

Demonstrate building and running multi-arch images

## Build 
```sh
docker build --target BASE -t ubuntu_x86 -f ./Dockerfile.ubuntu .
docker run -it --rm ubuntu_x86 
```