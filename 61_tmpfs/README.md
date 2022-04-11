# README

Demonstrate how to use `tmpfs` with Docker.  

`tmpfs` is a ramdis that only works on Docker linux.     

## Create

```sh
# allocate and show size inside container
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-size=2m alpine:latest /bin/df -h /tempdisk
```

```sh
# allocate space above size of disk
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /usr/bin/fallocate -l 5M /tempdisk/my.test
```

```sh
# 
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /bin/sh
```

```sh
# size seems to be max available
docker run -it --tmpfs /tempdisk alpine:latest /bin/sh
```

NOTE: Use `df -h` on the host to see allocations 
## Resources

https://fabianlee.org/2020/01/24/docker-working-with-local-volumes-and-tmpfs-mounts/

https://docs.docker.com/storage/tmpfs/
