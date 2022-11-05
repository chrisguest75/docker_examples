# README

Demonstrate `cosign` for signing OCI images.  

## Reason

Cosign gives the ability to sign images to verify that they have been produced by the key owner. K8S has the ability to have admission controllers that verify signatures and then reject images.  

## 📋 Prereqs

```sh
# install it
brew install cosign
# show version (time of writing GitVersion:1.9.0)
cosign version
# show help 
cosign --help 
```

## 🏠 Build test image

Build the image.  

```sh
# build the bash container
IMAGE_NAME=ttl.sh/$(uuidgen):1h
IMAGE_NAME=xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest:0.1.1
IMAGE_NAME=docker.io/chrisguest/ocitest:0.0.1
# quay.io does not work
IMAGE_NAME=quay.io/guestchris75/ocitest:0.0.1

# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -f ./Dockerfile -t "${IMAGE_NAME:l}" .

# run image
docker run -it --rm --name test --rm ${IMAGE_NAME:l} 

# push the image
docker push ${IMAGE_NAME:l}

# no signature yet
cosign verify --key cosign.pub ${IMAGE_NAME:l} | jq .
```

## Sign image

```sh
# generation keys (will password protect it)
cosign generate-key-pair   
# sign the image (this pushes a tag to the registry)
export COSIGN_PASSWORD=
cosign sign --key cosign.key ${IMAGE_NAME:l} 

docker inspect ${IMAGE_NAME:l}            
# it gets pushed as a seperate tag 
oras repository show-tags xxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/ocitest 

# verify the signature
cosign verify --key cosign.pub ${IMAGE_NAME:l} | jq .

crane manifest ${IMAGE_NAME:l} 
oras manifest fetch ${IMAGE_NAME:l} | jq .

# show the tag for the signature (seems to be pushed as a seperate tag). 
cosign triangulate ${IMAGE_NAME:l} 

# print manifest for signature
crane manifest $(cosign triangulate ${IMAGE_NAME:l}) | jq .
oras manifest fetch $(cosign triangulate ${IMAGE_NAME:l}) | jq .
```

## 👀 Resources

* sigstore/cosign [here](https://github.com/sigstore/cosign)
* A tool for Container Signing, Verification and Storage in an OCI registry. [here](https://github.com/sigstore/cosign/blob/main/doc/cosign.md)  
* Detailed Usage [here](https://github.com/sigstore/cosign/blob/main/USAGE.md)
* OCI Image Manifest Specification [here](https://github.com/opencontainers/image-spec/blob/main/manifest.md)
* Cosign Image Signatures [here](https://blog.sigstore.dev/cosign-image-signatures-77bab238a93)  
* Container Image Signing [here](https://www.redhat.com/en/blog/container-image-signing)  
