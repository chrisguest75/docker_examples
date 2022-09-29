# README

Demonstrate how to use `bake`  

TODO:

* Build multiple nix images and merge them into one.  
* Build with multiple contexts.  

## jq build

```sh
# build the packages 
docker build --no-cache --progress=plain -f Dockerfile.jq --target BUILDER -t nix-jq .  
docker build --no-cache --progress=plain -f Dockerfile.jq --target PRODUCTION -t nix-jq .    

# run to prove jq works
docker run --rm -it nix-jq

docker run --rm -it --entrypoint /busybox/sh nix-jq 

dive nix-jq

```

```sh
docker buildx bake --print
```

## Resource

https://docs.docker.com/engine/reference/commandline/buildx_bake/

https://github.com/docker/buildx

Docker Bake example
https://blog.kubesimplify.com/bake-your-container-images-with-bake

https://github.com/developer-guy/hello-world-buildx

https://docs.docker.com/build/customize/bake/hcl-funcs/

https://docs.docker.com/build/customize/bake/