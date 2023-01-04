# README

Demonstrate RUN mount caching package manager downloads.

NOTE: This does not seem to be working on mac. Rebuilds or the show cache do not show existing packages.  

## 🏠 Build Cache

```sh
# build
docker build --no-cache --progress=plain -t buildcache -f Dockerfile.buildcache .  
docker run -it --rm buildcache
```

## 👀 Build Cache

```sh
# build
docker build --no-cache --progress=plain -t showcache -f Dockerfile.showcache .  
docker run -it --rm showcache
```

## ⚡️ Show Cache

```sh
# run
docker run -it --rm buildcache

# step inside container
docker run -it --rm --entrypoint /bin/bash buildcache
```

## 👀 Resources

* How to Speed Up Your Dockerfile with BuildKit Cache Mounts [here](https://vsupalov.com/buildkit-cache-mount-dockerfile/)  
* GoogleContainerTools/base-images-docker [here](https://github.com/GoogleContainerTools/base-images-docker/blob/master/debian/reproducible/overlay/etc/apt/apt.conf.d/docker-clean)  
* mount=type=cache more in-depth explanation? [here](https://github.com/moby/buildkit/issues/1673)  
* RUN --mount=type=cache syntax [here](https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypecache)  
