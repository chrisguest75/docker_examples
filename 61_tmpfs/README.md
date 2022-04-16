# README

Demonstrate how to use `tmpfs` with Docker.  

`tmpfs` is a ramdisk that only works on Docker linux.     

## Create Container (--mount)

```sh
# allocate and show size inside container
docker run -it --rm --mount type=tmpfs,destination=/tempdisk,tmpfs-size=2m alpine:latest /bin/df -h /tempdisk
```

```sh
# allocate space above size of disk (no space left on device)
docker run -it --rm --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /usr/bin/fallocate -l 5M /tempdisk/my.test
```

```sh
# mount share 
docker run -it --rm --mount type=tmpfs,destination=/tempdisk,tmpfs-mode=770,tmpfs-size=4m alpine:latest /bin/sh

# show size of share 
df -h
```

## Create Container (--tmpfs)

Mount using `--tmpfs`

```sh
# size seems to be max available
docker run --rm -it --tmpfs /tempdisk alpine:latest /bin/sh

# NOTE: Use `df -h` on the host to see allocations
# show size of share is max size of memory
df -h

# on host use free 
free

# in the container allocate some tmpfs space 
/usr/bin/fallocate -l 100M /tempdisk/my.test
ls -la /tempdisk/my.test 

# on host use free again 
free
```

## Create Container (--mount & --tmpfs) memory limits

`tmpfs` also honours the configured max memory limits

```sh
# allocate and show size inside container
docker run -it --rm --memory=100m --mount type=tmpfs,destination=/tempdisk,tmpfs-size=600m alpine:latest /bin/sh

# in the container allocate some tmpfs space (it will fail) 
/usr/bin/fallocate -l 150M /tempdisk/my.test
```

```sh
# size seems to be max available
docker run --rm -it --memory=100m --tmpfs /tempdisk alpine:latest /bin/sh

# in the container allocate some tmpfs space (it will fail) 
/usr/bin/fallocate -l 150M /tempdisk/my.test
```

## Resources

* Docker: Working with local volumes and tmpfs mounts [here](https://fabianlee.org/2020/01/24/docker-working-with-local-volumes-and-tmpfs-mounts/)
* Use tmpfs mounts [here](https://docs.docker.com/storage/tmpfs/)
* Tmpfs is a file system which keeps all of its files in virtual memory. [here](https://www.kernel.org/doc/html/latest/filesystems/tmpfs.html)
* tmpfs wikipedia [here](https://en.wikipedia.org/wiki/Tmpfs)
