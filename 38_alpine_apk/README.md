# README.md
Demonstrate how to install a custom apk image.

Bats is v1.2.0 on 3.12.3 and we need to upgrade it.  
This technique can be used for installing bug fixes as well.   

```sh
# start alpine in a shell
docker run -it --entrypoint /bin/sh alpine:3.12.3
```

```sh
# find the registry sources 
> apk update
fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.12/community/x86_64/APKINDEX.tar.gz
```

```sh
# go find the package
open http://dl-cdn.alpinelinux.org/alpine/v3.13/main/x86_64/

# download it
wget https://dl-cdn.alpinelinux.org/alpine/v3.13/main/x86_64/bats-1.2.1-r0.apk

# Install the 3.13 package into 3.12.3 image.
apk add bats-1.2.1-r0.apk

# Get the new version of bats
> bats --version
Bats 1.2.1
```
