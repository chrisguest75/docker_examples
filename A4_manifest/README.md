# DOCKER MANIFEST

Docker has introduced a manifest command.  

REF: [80_crane/README.md](../80_crane/README.md)  
REF: [81_oras/README.md](../81_oras/README.md)  
REF: [94_regctl/README.md](../94_regctl/README.md)  

## Contents

- [DOCKER MANIFEST](#docker-manifest)
  - [Contents](#contents)
  - [Inspecting public images](#inspecting-public-images)
  - [Retagging (without pull)](#retagging-without-pull)
  - [Pushing](#pushing)
  - [Inspecting after push](#inspecting-after-push)
  - [Updating](#updating)
  - [Resources](#resources)

NOTES:

- There doesn't seem to be a way to list local manifests.
- After a push you can remove a local manifest by name and then inspect the remote version of it.
- The manifest only contains a pointer to the sha256 of the image and not the tag name.
- You can add multiple images to the manifest for the same architecture. TODO: Test this behaviour on client pull.

## Inspecting public images

```sh
docker manifest inspect nginx:1.27.0
docker manifest inspect redis:7.2 
```

## Retagging (without pull)

```sh
docker manifest create $REPOSITORY:$TAG_NEW $REPOSITORY:$TAG_OLD
docker manifest push $REPOSITORY:$TAG_NEW
```

## Pushing

```sh
# login
AWS_PROFILE=myprofile AWS_REGION=eu-west-1 aws ecr get-login-password | docker login --username AWS --password-stdin 000000000000.dkr.ecr.eu-west-1.amazonaws.com

# push nginx as an image
docker tag nginx:1.27.0 000000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0         
docker push 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0

# retagging with metadata
docker manifest create 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0
docker manifest push 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image

# this will pull the aliased image.
docker pull 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
docker run 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
```

## Inspecting after push

```sh
# remove the local manifest
docker manifest rm 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
docker manifest inspect 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
```

## Updating

```sh
# remove before updating
docker manifest rm 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
docker manifest create 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:1.27.0
docker manifest push 00000000000.dkr.ecr.eu-west-1.amazonaws.com/test-manifest-push:new_image
```

## Resources

* https://docs.docker.com/reference/cli/docker/manifest/
* https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/

