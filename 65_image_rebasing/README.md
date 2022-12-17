# README

Demonstrate building a simple nodejs app and changing the version without having to rebuild app.  

## Reason

If we can rebase containers we can address CVEs without having to rebuild the full container.  


TODO:

* It doesn't seem to work how I'd expect.  I'd expect link=true to be recognised as a cached layer.  

## Ubuntu Example

## Normal Build

NOTE: Would expect this to use the cache for `apt install`  

```sh
# clean start
docker rmi $(docker images -aq) --force  
docker builder prune --all -f    

# build an initial image
docker buildx build -f Dockerfile.ping . -t $(basename $(pwd))_18_04 --build-arg IMAGE=ubuntu:18.04
docker run -it --rm  $(basename $(pwd))_18_04

# switch ubuntu version (no caching)
docker buildx build -f Dockerfile.ping . -t $(basename $(pwd))_20_04 --build-arg IMAGE=ubuntu:20.04
docker run -it --rm  $(basename $(pwd))_20_04

# switch ubuntu version (no caching)
docker buildx build -f Dockerfile.ping . -t $(basename $(pwd))_22_04 --build-arg IMAGE=ubuntu:22.04
docker run -it --rm  $(basename $(pwd))_22_04
```

### First build

From a clean start both images should perform a full build  

```sh
cd ./tool

docker rmi $(docker images -aq) --force  
docker builder prune --all -f   

export DOCKERFILE=Dockerfile

# no caching
docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_13_2 --build-arg BUILDIMAGE=node:16.13.2-bullseye --build-arg PRODUCTIONIMAGE=node:16.13.2-bullseye
docker run -it --rm  $(basename $(pwd))_16_13_2 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_15 --build-arg BUILDIMAGE=node:16.15-bullseye --build-arg PRODUCTIONIMAGE=node:16.15-bullseye
docker run -it --rm  $(basename $(pwd))_16_15 
```

### Cached build

Once built rebuilding will use the cache for both.  

```sh
docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_13_2 --build-arg BUILDIMAGE=node:16.13.2-bullseye --build-arg PRODUCTIONIMAGE=node:16.13.2-bullseye
docker run -it --rm  $(basename $(pwd))_16_13_2 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_15 --build-arg BUILDIMAGE=node:16.15-bullseye --build-arg PRODUCTIONIMAGE=node:16.15-bullseye
docker run -it --rm  $(basename $(pwd))_16_15 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd)) --build-arg BUILDIMAGE=node:16.13.2-bullseye --build-arg PRODUCTIONIMAGE=node:16.15-bullseye
docker run -it --rm  $(basename $(pwd)) 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd)) --build-arg BUILDIMAGE=node:16.15-bullseye --build-arg PRODUCTIONIMAGE=node:16.13.2-bullseye
docker run -it --rm  $(basename $(pwd)) 
```

### Rebase Build

```sh
docker rmi $(docker images -aq) --force  
docker builder prune --all -f   

export DOCKERFILE=Dockerfile.rebase 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_13_2 --build-arg BUILDIMAGE=node:16.13.2-bullseye --build-arg PRODUCTIONIMAGE=node:16.13.2-bullseye
docker run -it --rm  $(basename $(pwd))_16_13_2 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd))_16_15 --build-arg BUILDIMAGE=node:16.15-bullseye --build-arg PRODUCTIONIMAGE=node:16.15-bullseye
docker run -it --rm  $(basename $(pwd))_16_15 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd)) --build-arg BUILDIMAGE=node:16.13.2-bullseye --build-arg PRODUCTIONIMAGE=node:16.15-bullseye
docker run -it --rm  $(basename $(pwd)) 

docker buildx build -f $DOCKERFILE . -t $(basename $(pwd)) --build-arg BUILDIMAGE=node:16.15-bullseye --build-arg PRODUCTIONIMAGE=node:16.13.2-bullseye
docker run -it --rm  $(basename $(pwd)) 
```

## Inspecting

```sh
docker image save -o ./$(basename $(pwd))_16_13_2.tar $(basename $(pwd))_16_13_2
mkdir -p ./out/$(basename $(pwd))_16_13_2 && tar -xvf ./$(basename $(pwd))_16_13_2.tar -C $_


docker image save -o ./$(basename $(pwd))_16_15.tar $(basename $(pwd))_16_15
mkdir -p ./out/$(basename $(pwd))_16_15 && tar -xvf ./$(basename $(pwd))_16_15.tar -C $_
```


## Resources

* Dockerfile frontend syntaxes [here](https://github.com/moby/buildkit/blob/dockerfile/1.4.0/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link)  
* Image rebase and improved remote cache support in new BuildKit [here](https://www.docker.com/blog/image-rebase-and-improved-remote-cache-support-in-new-buildkit/)
* Merge and Diff Ops [here](https://github.com/moby/buildkit/blob/v0.10.0/docs/merge%2Bdiff.md)  
* Merge+Diff: Building DAGs More Efficiently and Elegantly [here](https://www.docker.com/blog/mergediff-building-dags-more-efficiently-and-elegantly/)
