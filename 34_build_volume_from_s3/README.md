# Docker Build Volumes

Demonstrate how to build a data volume for use by other containers.  

TODO:

* Is there a way to do this directly from a docker file?

## Reason

It's useful to be able to build volumes automatically for use as test data.  

## Create volume

```sh
# create a volume
docker volume create 34_build_volume_from_s3 

docker volume ls

docker volume inspect 34_build_volume_from_s3    

# build container that builds volume
docker build -f Dockerfile -t 34_build_volume_from_s3:latest .
```

## Fill volume

Share the volume into the container that builds it.  

```sh
# build volume
export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1
docker run --rm -it -v 34_build_volume_from_s3:/testdata -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION 34_build_volume_from_s3:latest

# after executing use another container to view volume
docker run --rm -it -v 34_build_volume_from_s3:/testdata --entrypoint /bin/bash ubuntu:22.04

# show volume
ls /testdata/
```

## Remove volume

```sh
docker volume rm 34_build_volume_from_s3              

# or
docker volume prune       
```

## Troubleshooting

```sh
docker run --rm -it -v 34_build_volume_from_s3:/testdata -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION --entrypoint /bin/bash 34_build_volume_from_s3:latest

# show contents of the volume
ls -l /testdata
```

## Creating anonymous volume during run

Use the `VOLUME` command to create an anonymous volume.  
NOTE: THIS IS NOT WORKING. THE VOLUME IS EMPTY AFTER EXECUTING.  

```sh
docker build -f Dockerfile.volume -t 34_build_volume_from_s3_volume:latest .

export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1
# NOTE: Using --rm removes the volume immediately as well.  
docker run --rm -it -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION --name 34_build_volume_from_s3_volume 34_build_volume_from_s3_volume:latest

docker run -it -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION --name 34_build_volume_from_s3_volume 34_build_volume_from_s3_volume:latest

# list volumes sorted by creation
docker volume ls --format '{{.Name}}' | xargs -L 1 docker volume inspect | jq -s -c '.[][0] | {CreatedAt, Name}' | jq -s '. | sort_by(.CreatedAt)'

# nsenter into the host docker alpine 
# IT's EMPTY
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
ls -l /var/lib/docker/volumes/

# after executing use another container to view volume
# IT's EMPTY
docker run --rm -it -v 75d03cdd541893fce5cf6324a2e673a9e03a6b8a52d2a5da9a3b223b2c95e4e3:/testdata --entrypoint /bin/bash ubuntu:22.04
```

## Resources

* Understanding Docker Volumes [here](https://earthly.dev/blog/docker-volumes/)
* Docker Volume [here](https://docs.docker.com/engine/reference/builder/#volume)
* Guide to Docker Volumes [here](https://www.baeldung.com/ops/docker-volumes)
* Creating Volume Mount from Dockerfile [here](https://dockerlabs.collabnix.com/beginners/volume/create-a-volume-mount-from-dockerfile.html)
* Named Volumes in Dockerfile #30647 [here](https://github.com/moby/moby/issues/30647#issuecomment-276882545)  
