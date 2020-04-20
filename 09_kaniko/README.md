# Script to follow
Demonstrate using Kaniko to build a Docker image  

TODO:
1. Same image built with kaniko versus docker 
1. Analyse the size differences between kaniko and docker
1. Container-diff

## Prereqs

```sh
mkdir -p ./output
```

## Kaniko build of image
```sh
docker run -v $(pwd):/workspace -v $(pwd)/output:/output -it gcr.io/kaniko-project/executor:latest --context dir:///workspace/ --no-push --destination=image --tarPath=/output/kaniko_test.tar 
```

## Docker build of image
```sh
docker build -f Dockerfile -t dockerkanikocompare .
docker save -o ./output/dockerbuild.tar dockerkanikocompare
```


Kaniko Troubleshooting
```sh
# Run a shell inside kaniko container
docker run -v $(pwd):/workspace -it --entrypoint=/busybox/sh gcr.io/kaniko-project/executor:debug

# Run the executor
cd /workspace
/kaniko/executor --context dir://workspace/ --no-push --build-arg sleeptime=10 
```
