# README

Demonstrate how to use `crane`  

TODO:  

* Rebasing an image using `crane rebase`

## Install

```sh
brew install crane

crane --help 
```

## 🏠 Build test image

Build the image.  

```sh
IMAGE_NAME=ttl.sh/$(uuidgen):1h
# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -t "${IMAGE_NAME:l}" .

# run ping duckduckgo
docker run -it --rm --name pinger --rm ${IMAGE_NAME:l} https://duckduckgo.com

# push the image
docker push ${IMAGE_NAME:l}
```

## Manifests

```sh
crane manifest ${IMAGE_NAME:l} | jq '.'  

# this is 
crane manifest nginx:1.23.1 | jq '.'  

# calculate size (also works with ECR)
crane manifest xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/myawsimage | jq '.config.size + ([.layers[].size] | add)'
```

## Resources

* google/go-containerregistry [here](https://github.com/google/go-containerregistry)  
* crane Recipes [here](https://github.com/google/go-containerregistry/blob/main/cmd/crane/recipes.md)  
* rebase [here](https://github.com/google/go-containerregistry/blob/main/cmd/crane/rebase.md)  
* crane docs [here](https://github.com/google/go-containerregistry/tree/main/cmd/crane/doc)  
https://ttl.sh/