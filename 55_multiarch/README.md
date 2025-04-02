# README

Demonstrate building and running multi-arch images

📝 TODO:

* retagging multiarch
    * nerdctl
    * ctr
    * manifest reconstruct

* ARM not running on nixos (it builds)
* buildx builders
* build multi image manifest is not working on default install
* `docker run --privileged --rm tonistiigi/binfmt --install all` https://github.com/docker/buildx/issues/1986

NOTES:

* REF: QEMU example [here](https://github.com/chrisguest75/sysadmin_examples/tree/master/16_qemu)  
* REF: [79_bake/README.md](../79_bake/README.md)
* REF: [94_regctl/README.md](../94_regctl/README.md)

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

## 🏠 Build and Run

NOTE: If on ubuntu then install `sudo apt install qemu-user-static`.  Once installed running ARM images just works.  

### Just

```sh
# build two different images
just bake-build

# run individual images
just docker-run-amd64
just docker-run-arm64

export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-2 
export AWS_ACCOUNT=000000000000

# create an ecr to test multi-arch
just --set AWS_PROFILE ${AWS_PROFILE} --set AWS_ACCOUNT ${AWS_ACCOUNT} ecr-create
just --set AWS_PROFILE ${AWS_PROFILE} --set AWS_ACCOUNT ${AWS_ACCOUNT} ecr-login
# build and push 
just --set DOCKER_IMAGE_NAME ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch --set DOCKER_IMAGE_TAG latest bake-build-push ubuntu-image-multi

# show manifest images 
docker images --tree
just docker-run-ecr ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch:latest "linux/amd64" 
just docker-run-ecr ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch:latest "linux/arm64" 
```

## Retagging

NOTE: Docker will only pull one platform at a time even if the image is multi platform.  

```sh
# create a target repo
just --set AWS_PROFILE ${AWS_PROFILE} --set AWS_ACCOUNT ${AWS_ACCOUNT} --set DOCKER_IMAGE_NAME 55_multiarchtarget ecr-create    
```

### Docker

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-2 
export AWS_ACCOUNT=000000000000
docker pull --platform linux/amd64 "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch"
docker pull --platform linux/arm64 "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch"
docker manifest inspect "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch:latest"
```

### Regclient

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-2 
export AWS_ACCOUNT=000000000000
# create ecr in same account
just --set AWS_PROFILE ${AWS_PROFILE} --set AWS_ACCOUNT ${AWS_ACCOUNT} --set DOCKER_IMAGE_NAME 55_multiarchtesttarget ecr-create    
AWS_PROFILE=${AWS_PROFILE} aws ecr get-login-password | regctl registry login --user AWS --pass-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
regctl repo ls ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com 

# works like a charm...
regctl image copy "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarch:latest" "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/55_multiarchtarget:latest"

# create another account
export AWS_PROFILE_SRC=myprofile
export AWS_REGION_SRC=eu-west-2 
export AWS_ACCOUNT_SRC=000000000000
export AWS_PROFILE_DST=myprofiledst
export AWS_REGION_DST=eu-west-2 
export AWS_ACCOUNT_DST=000000000000
just --set AWS_PROFILE ${AWS_PROFILE_DST} --set AWS_ACCOUNT ${AWS_ACCOUNT_DST} --set DOCKER_IMAGE_NAME 55_multiarchtesttarget ecr-create

AWS_PROFILE=${AWS_PROFILE_DST} aws ecr get-login-password | regctl registry login --user AWS --pass-stdin ${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com

regctl registry config

regctl repo ls "${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com" 

# copy across account
regctl image copy "${AWS_ACCOUNT_SRC}.dkr.ecr.${AWS_REGION_SRC}.amazonaws.com/55_multiarch:latest" "${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com/55_multiarchtesttarget:latest"
docker manifest inspect "${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com/55_multiarchtesttarget:latest"
regctl tag ls "${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com/55_multiarchtesttarget:latest"                                   
regctl manifest get "${AWS_ACCOUNT_DST}.dkr.ecr.${AWS_REGION_DST}.amazonaws.com/55_multiarchtesttarget:latest"                   
```

### CLI (without Bake)

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
* https://medium.com/@john.shaw.zen/docker-buildx-bake-pass-in-secret-e8ccd1e43a9d
* https://dbhi.github.io/qus/intro.html
* https://medium.com/hprog99/a-comprehensive-guide-to-docker-bake-building-bundling-and-shipping-applications-at-scale-77030333586f