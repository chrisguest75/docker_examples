# README

Demonstrate building and running multi-arch images

QEMU example [here](https://github.com/chrisguest75/sysadmin_examples/tree/master/16_qemu)  

📝 TODO:

* buildx builders
* arm not running on nixos
* build multi image manifest is not working on default install
* push image to ecr 

## Supported architectures  

```sh
# list the supported platforms
docker buildx ls   
```

## Pulling images architectures

```sh
# clean out all the images
docker system prune --all --force

docker pull --platform=linux/arm64 ubuntu:20.04 
# this will pull but without a tag ubuntu:<none>
docker pull --platform=linux/amd64 ubuntu:20.04 

# architecture of each image
docker images -q | xargs -L 1 docker inspect | jq -c '.[] | [.Id, .Architecture, .RepoTags[]]'
```

## 🏠 Build

### Just

```sh
just bake-build

# run
just docker-run-amd64
just docker-run-arm64


# create an ecr to test multi-arch
just --set AWS_PROFILE myprofile --set AWS_ACCOUNT 0000000000000 create-ecr

just --set DOCKER_IMAGE_NAME 0000000000000.dkr.ecr.eu-west-2.amazonaws.com/55_multiarch --set DOCKER_IMAGE_TAG latest bake-build-push ubuntu-image-multi
```

### CLI

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

## 👀 Resources

* Docker Buildx [here](https://docs.docker.com/buildx/working-with-buildx/)
* Building Multi-Arch Images for Arm and x86 with Docker Desktop [here](https://www.docker.com/blog/multi-arch-images/)
* https://medium.com/@life-is-short-so-enjoy-it/docker-how-to-build-and-push-multi-arch-docker-images-to-docker-hub-64dea4931df9