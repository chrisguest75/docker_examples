# README

Demonstrate `cosign` for signing OCI images.  

TODO:  

* understand how oci registries and signatures work
* get it working with quay.io  
* verify an image.  
* unpack the image  

## 📋 Prereqs

```sh
# install it
brew install cosign
cosign --help 
# show version
cosign version
```

## 🏠 Build test image

Build the image.  

```sh
# build the bash container
IMAGE_NAME=ttl.sh/$(uuidgen):1h
# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -f ./Dockerfile -t "${IMAGE_NAME:l}" .

# run image
docker run -it --rm --name test --rm ${IMAGE_NAME:l} 

# push the image
docker push ${IMAGE_NAME:l}
```

## Sign image

```sh
cosign generate-key-pair   
export COSIGN_PASSWORD=
cosign sign --key cosign.key ${IMAGE_NAME:l} 

# verify the signature
cosign verify --key cosign.pub ${IMAGE_NAME:l} | jq .

crane manifest ${IMAGE_NAME:l} 


cosign triangulate ${IMAGE_NAME:l} 
```

## 👀 Resources

* sigstore/cosign [here](https://github.com/sigstore/cosign)

https://github.com/sigstore/cosign/blob/main/doc/cosign.md
https://github.com/sigstore/cosign/blob/main/USAGE.md

* OCI Image Manifest Specification [here](https://github.com/opencontainers/image-spec/blob/main/manifest.md)

