# README

Demonstrate how to use `tmpfs` with Docker.  

`tmpfs` is a ramdisk that only works on Docker linux.     

## Create Container (--mount)

```sh
# allocate and show size inside container
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-size=2m alpine:latest /bin/df -h /tempdisk
```

```sh
# allocate space above size of disk (no space left on device)
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /usr/bin/fallocate -l 5M /tempdisk/my.test
```

```sh
# mount share 
docker run -it --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /bin/sh

# show size of share 
df -h
```

## Create Container (--tmpfs)

Mount using `--tmpfs`

```sh
# size seems to be max available
docker run -it --tmpfs /tempdisk alpine:latest /bin/sh

# NOTE: Use `df -h` on the host to see allocations
# show size of share is max size of memory
df -h
```

## Resources

* Docker: Working with local volumes and tmpfs mounts [here](https://fabianlee.org/2020/01/24/docker-working-with-local-volumes-and-tmpfs-mounts/)
* Use tmpfs mounts [here](https://docs.docker.com/storage/tmpfs/)

