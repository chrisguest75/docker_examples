# DOCKER MANIFEST

Docker has introduced a manifest command.  

REF: [80_crane/README.md](../80_crane/README.md)  
REF: [81_oras/README.md](../81_oras/README.md)  
REF: [94_regctl/README.md](../94_regctl/README.md)  

## Inspecting

```sh
docker manifest inspect nginx:1.27.0
docker manifest inspect redis:7.2 
```

## Retagging (without pull)

```sh
docker manifest create $REPOSITORY:$TAG_NEW $REPOSITORY:$TAG_OLD
docker manifest push $REPOSITORY:$TAG_NEW
```

## Example

```sh
# login
AWS_PROFILE=myprofile AWS_REGION=eu-west-1 aws ecr get-login-password | docker login --username AWS --password-stdin 000000000000.dkr.ecr.eu-west-1.amazonaws.com

# push nginx as an image
docker tag nginx:1.27.0 000000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0         
docker push 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0

# retagging with metadata
docker manifest create 633946266320.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0
docker manifest push 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image

# this will pull the aliased image.
docker pull 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
docker run 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
```

## Resources

* https://docs.docker.com/reference/cli/docker/manifest/
* https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/

