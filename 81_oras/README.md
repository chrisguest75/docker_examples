# README

Demonstrate how to use OCI Registry-as-Storage (ORAS)  

## Reason

Registries are evolving as generic artifact stores. To enable this goal, the ORAS project provides a way to push and pull OCI Artifacts to and from OCI Registries.  

TODO:

* caching?
* layers?  
* artifacts?

## Install

```sh
# install oras package
brew install oras
```

## Browsing

You can get quick summaries of artifacts/images in a repository  

```sh
. ./.env 

# login
AWS_PROFILE=myprofile aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com

# list images
oras repository list xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com

# show tags
oras repository show-tags xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest

# manifest for an image/artifact
oras manifest fetch xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest:0.0.1 | jq .
```

## Docker (works)

Goto [https://hub.docker.com/](https://hub.docker.com/)

```sh
. ./.env 

mkdir -p ./build
echo "bar" > ./build/foo.txt 
echo "{\"name\":\"foo\",\"value\":\"bar\"}" > ./build/config.json

IMAGE_VERSION=0.0.1
oras push docker.io/chrisguest/ocitest:${IMAGE_VERSION} --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

mkdir -p ./pulled
oras pull -o ./pulled docker.io/chrisguest/ocitest:${IMAGE_VERSION}

echo "oci is cool" >> ./build/foo.txt 
IMAGE_VERSION=0.0.2

oras push docker.io/chrisguest/ocitest:${IMAGE_VERSION} --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

mkdir -p ./pulled/${IMAGE_VERSION}
oras pull -o ./pulled/${IMAGE_VERSION} docker.io/chrisguest/ocitest:${IMAGE_VERSION}
```

## AWS (works)

```sh
IMAGE_VERSION=0.0.1
oras push xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest:${IMAGE_VERSION} --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

mkdir -p ./pulled/${IMAGE_VERSION}

oras pull -o ./pulled/${IMAGE_VERSION} xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest:${IMAGE_VERSION}
```

## Quay (not working)

Goto [https://quay.io/](https://quay.io/)  

```sh
. ./.env 

echo "bar" > ./build/foo.txt 
echo "{\"name\":\"foo\",\"value\":\"bar\"}" > ./build/config.json

IMAGE_VERSION=0.0.1
oras push quay.io/guestchris75/ocitest:${IMAGE_VERSION} --username "$QUAYUSER" --password "$QUAYPASS" --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

IMAGE_VERSION=0.0.1
oras push quay.io/guestchris75/ocitest:${IMAGE_VERSION} --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

docker login quay.io
oras push quay.io/guestchris75/ocitest:${IMAGE_VERSION} --config ./build/config.json:application/vnd.docker.volume.v1+tar.gz ./build/foo.txt:text/plain

```

## Resources

* ORAS website [here](https://oras.land/)
* OCI Image Manifest Specification [here](https://github.com/opencontainers/image-spec/blob/main/manifest.md)
* OCI Image Media Types [here](https://github.com/opencontainers/image-spec/blob/main/media-types.md)
* Media Type Specifications and Registration Procedures [here](https://www.rfc-editor.org/rfc/rfc6838)
* Announcing Docker Hub OCI Artifacts Support [here](https://www.docker.com/blog/announcing-docker-hub-oci-artifacts-support/)  
* Open Container Initiative Distribution Specification [here](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#api)  
* Chapter 13. OCI Support and Red Hat Quay [here](https://access.redhat.com/documentation/en-us/red_hat_quay/3/html/use_red_hat_quay/oci-intro)
* Image Manifest V 2, Schema 2 [here](https://docs.docker.com/registry/spec/manifest-v2-2/)
