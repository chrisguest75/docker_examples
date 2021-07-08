# README
Demonstrate different ways to find distro versions inside a container

# Ubuntu
```sh
# oci image labels
docker pull ubuntu:20.04  
docker inspect -f {{.Config.Labels}} ubuntu:20.04      

# run the container
docker run --rm -it --entrypoint /bin/bash ubuntu:20.04

# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apt list
apt update
apt list --upgradable
```


# Alpine
```sh
# oci image labels
docker pull alpine:3.14.0  
docker inspect -f {{.Config.Labels}} alpine:3.14.0   

# run the container
docker run --rm -it --entrypoint /bin/sh alpine:3.14.0   

# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apk list --installed
apk list -u
```

# NixOS
```sh
# oci image labels
docker pull nixos/nix:2.3.12
docker inspect -f {{.Config.Labels}} nixos/nix:2.3.12

# run the container
docker run --rm -it --entrypoint /bin/sh nixos/nix:2.3.12

# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apk list --installed
apk list -u
```

# Debian
```sh
# oci image labels
docker pull debian:bullseye
docker inspect -f {{.Config.Labels}} debian:bullseye

# run the container
docker run --rm -it --entrypoint /bin/bash debian:bullseye

# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apt list
apt update
apt list --upgradable
```

# Fedora
```sh
# oci image labels
docker pull fedora:34
docker inspect -f {{.Config.Labels}} fedora:34

# run the container
docker run --rm -it --entrypoint /bin/bash fedora:34

# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
yum list --installed
yum list --upgrades
```

