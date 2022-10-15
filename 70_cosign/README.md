# README

Demonstrate `cosign` for signing OCI images.  

TODO:  

* get it working with quay.io  
* verify an image.  
* unpack the image  

## 📋 Prereqs

```sh
# install it
brew install cosign
cosign --help 
```

## Building

```sh
# build the bash container
docker build -t signed_image -f ./Dockerfile .

# execute the container
docker run --rm -it --name signed_image signed_image
```


cosign generate-key-pair   
export COSIGN_PASSWORD=
cosign sign --key cosign.key signed_image


## 👀 Resources

https://github.com/sigstore/cosign