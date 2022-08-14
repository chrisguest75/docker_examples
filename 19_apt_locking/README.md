# README

Demonstrates locking apt to specific versions of packages.  

## 🏠 Build

```sh
UBUNTU_VERSION=1604
UBUNTU_VERSION=1804
UBUNTU_VERSION=2004
UBUNTU_VERSION=2204

# build
docker build --no-cache -t ${UBUNTU_VERSION}.apt_locking -f ${UBUNTU_VERSION}.Dockerfile .  
```

## ⚡️ Run

```sh
# run
docker run -it --rm ${UBUNTU_VERSION}.apt_locking 
docker run -it --rm --entrypoint /bin/bash ${UBUNTU_VERSION}.apt_locking 
```

## Resources

