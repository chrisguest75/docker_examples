# Docker Build Volumes

Demonstrate how to build a data volume for use by other containers.  

TODO: 

* Is there a way to do this directly from a docker file?

## Create volume

```sh
# create a volume
docker volume create 34_build_volume_from_s3 

docker volume ls

docker inspect 34_build_volume_from_s3    

docker build -f Dockerfile -t 34_build_volume_from_s3:latest . 
```

## Fill volume

```sh
export AWS_PROFILE=trint-dev
export AWS_REGION=us-east-1
docker run --rm -it -v 34_build_volume_from_s3:/testdata -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION 34_build_volume_from_s3:latest
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

## Resources

* Understanding Docker Volumes [here](https://earthly.dev/blog/docker-volumes/)
* Docker Volume [here](https://docs.docker.com/engine/reference/builder/#volume)
* Guide to Docker Volumes [here](https://www.baeldung.com/ops/docker-volumes)
* Creating Volume Mount from Dockerfile [here](https://dockerlabs.collabnix.com/beginners/volume/create-a-volume-mount-from-dockerfile.html)
