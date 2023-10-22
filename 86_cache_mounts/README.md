# README

Demonstrate BUILD mount caching package manager downloads.

NOTES:

* Using `--no-cache` resets the cache.  
* Using the cache means you don't have to clean up after package installation.  

TODO:

* Why does `touch ./modifyme.txt && echo "modify" >> ./modifyme.txt` this not invalidate context?
* How are caches shared between images?  

## 👀 Custom Cache

Use a custom folder and cache it.  

```sh
# build
touch ./modifyme.txt && echo "modify" > ./modifyme.txt
docker build --no-cache --progress=plain -t customcache -f Dockerfile.customcache .  

# repeat this and see the number of files in cache grow
touch ./modifyme.txt && echo "modify" >> ./modifyme.txt
docker build --progress=plain -t customcache -f Dockerfile.customcache .  

# this will fail as /mycache does not exist
docker run -it --rm customcache

# step inside container
docker run -it --rm --entrypoint /bin/bash customcache
```

## Show APT Cache

```sh
# build
touch ./modifyme.txt && echo "modify" > ./modifyme.txt
docker build --no-cache --progress=plain -t showcache -f Dockerfile.showcache .  

# repeat this and see the number of files in cache grow
touch ./modifyme.txt && echo "modify" >> ./modifyme.txt
docker build --progress=plain -t showcache -f Dockerfile.showcache .  

# step inside container
docker run -it --rm --entrypoint /bin/bash showcache
ls -lR /var/cache/apt
ls -lR /var/lib/apt
```

## 🏠 Build APT Cache

Use cache to cache APT packages.  

```sh
# build
touch ./modifyme.txt && echo "modify" > ./modifyme.txt
docker build --no-cache --progress=plain -t buildcache -f Dockerfile.buildcache .  

touch ./modifyme.txt && echo "modify" >> ./modifyme.txt
docker build --progress=plain -t buildcache -f Dockerfile.buildcache .  

docker run -it --rm buildcache
```

## 👀 Resources

* How to Speed Up Your Dockerfile with BuildKit Cache Mounts [here](https://vsupalov.com/buildkit-cache-mount-dockerfile/)  
* GoogleContainerTools/base-images-docker [here](https://github.com/GoogleContainerTools/base-images-docker/blob/master/debian/reproducible/overlay/etc/apt/apt.conf.d/docker-clean)  
* mount=type=cache more in-depth explanation? [here](https://github.com/moby/buildkit/issues/1673)  
* RUN --mount=type=cache syntax [here](https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypecache)  
