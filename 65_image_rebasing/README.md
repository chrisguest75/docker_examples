# README

Demonstrate how to rebase a container image.

TODO:

* THIS IS NOT WORKING HOW I EXPECT
* Build a simple nodejs app and change the version without having to reinstall app

## Ubuntu Example

## Normal Build

```sh
# clean start
cd ./tool/src
docker rmi $(docker images -aq) --force  
docker builder prune --all -f    

docker build -f Dockerfile.ping . -t $(basename $(pwd)) --build-arg IMAGE=ubuntu:18.04

docker run -it --rm  $(basename $(pwd)) 

docker build -f Dockerfile.ping . -t $(basename $(pwd)) --build-arg IMAGE=ubuntu:20.04

docker build -f Dockerfile.ping . -t $(basename $(pwd)) --build-arg IMAGE=ubuntu:21.04
```

### First build

From a clean start both images should perform a full build  

```sh
# no caching
docker build -f Dockerfile . -t $(basename $(pwd)) --build-arg IMAGE=node:16.13.2-bullseye

# no caching.  Rebuilds everything as no shaed parents
docker build -f Dockerfile . -t $(basename $(pwd)) --build-arg IMAGE=node:16.15-bullseye
```

### Cached build

Once built rebuilding will use the cache for both.  

```sh
# rebuild and we see caching
docker build -f Dockerfile . -t $(basename $(pwd)) --build-arg IMAGE=node:16.13.2-bullseye

# rebuild and we see caching
docker build -f Dockerfile . -t $(basename $(pwd)) --build-arg IMAGE=node:16.15-bullseye
```

## Rebase Build

```sh
# clean start again
docker rmi $(docker images -aq) --force  
docker builder prune --all -f     
```

### Build

```sh
docker build -f Dockerfile.rebase . -t $(basename $(pwd)) --build-arg IMAGE=node:16.13.2-bullseye

# rebase with new nodejs
docker build -f Dockerfile.rebase . -t $(basename $(pwd)) --build-arg IMAGE=node:16.15-bullseye
```


## Resources

* Dockerfile frontend syntaxes [here](https://github.com/moby/buildkit/blob/dockerfile/1.4.0/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link)  
* Image rebase and improved remote cache support in new BuildKit [here](https://www.docker.com/blog/image-rebase-and-improved-remote-cache-support-in-new-buildkit/)
* Merge and Diff Ops [here](https://github.com/moby/buildkit/blob/v0.10.0/docs/merge%2Bdiff.md)  
* Merge+Diff: Building DAGs More Efficiently and Elegantly [here](https://www.docker.com/blog/mergediff-building-dags-more-efficiently-and-elegantly/)
