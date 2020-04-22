# Script to follow
Demonstrate using Kaniko to build a Docker image  

[Docs](https://github.com/GoogleContainerTools/kaniko/blob/master/README.md)

TODO:
1. Container-diff
1. Does docker have an immutable option?
1. Caching 
1. dive does not seem to work on kaniko builds
1. oci format??
1. remove timestamps for kaniko image
1. import kaniko image into docker registry.  

## NOTES
1. The .tar files from Kaniko are much smaller than the docker counterparts

## Prereqs
Install container-diff and [dive](../30_dive_ci/README.md)

```sh
brew install container-diff
brew install dive
```

Create an output directory
```sh
mkdir -p ./output
mkdir -p ./cache
```
## Creating cache
Create a cache folder to speed up rebuilds
```sh
docker run -v $(pwd):/workspace gcr.io/kaniko-project/warmer:latest --cache-dir=/workspace/cache --image=ubuntu:16.04
```

## Kaniko build of image
Use reproducible builds to see if we can reproduce sha1
```sh
# kaniko build
TAR_NAME=kanikobuild_$(date "+%Y%m%d-%H%M%S")
docker run -v $(pwd):/workspace -v $(pwd)/output:/output -it gcr.io/kaniko-project/executor:latest --context dir:///workspace/ --no-push --destination=kanikobuild --tarPath=/output/${TAR_NAME}.tar --reproducible --cache-dir=/workspace/cache --cache=false
docker import ./output/${TAR_NAME}.tar ${TAR_NAME}:latest
```

## Docker build of image
```sh
# docker build and tar save
docker build --no-cache -f Dockerfile -t dockerkanikocompare .
docker save -o ./output/dockerbuild.tar dockerkanikocompare
```

## Compare
Output the SHA1 for each image 
```sh
find ./output/ -name "*.tar" -exec container-diff analyze {} \;
```

If you repeat the process and ensuring caching is turned off you will see different SHA being created.  

## Analyse
We can also use the dive tool to look inside the container image 
```sh
dive ./output/dockerbuild.tar --source docker-archive
```

## Kaniko Troubleshooting
```sh
# Run a shell inside kaniko container
docker run -v $(pwd):/workspace -it --entrypoint=/busybox/sh gcr.io/kaniko-project/executor:debug

# Run the executor
cd /workspace
/kaniko/executor --context dir://workspace/ --no-push 
```
