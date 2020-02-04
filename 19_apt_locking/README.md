# README.md
Demonstrates locking apt to specific versions of packages.

## Installation
```
docker build -t 1604.apt_locking -f 1604.Dockerfile .  
docker build -t 1804.apt_locking -f 1804.Dockerfile .  
```

## Run 
```
docker run -it --entrypoint /bin/bash 1604.apt_locking 
docker run -it --entrypoint /bin/bash 1804.apt_locking 
```

