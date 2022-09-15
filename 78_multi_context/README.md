# README

Demonstrate using multiple build contexts.  

## Build

```sh
cd ./context1
```

### Single context

```sh
# build
docker buildx build --target BASE -f Dockerfile.single -t context1 .

# run cowsay
docker run --rm -it --name context1 context1  

# enter 
docker run --rm -it --entrypoint /bin/bash --name context1 context1  

> ls
```

### Dual context

```sh
# build
docker buildx build --target BASE -f Dockerfile.dual -t context2 --build-context context2=../context2 .

# run cowsay
docker run --rm -it --name context2 context2  

# enter 
docker run --rm -it --entrypoint /bin/bash --name context2 context2

> ls
```

### Packages

```sh
docker buildx build -f Dockerfile.packages -t packages --build-context context2=../context2 --build-context packages=../packages .

# run cowsay
docker run --rm -it --name packages packages  

# enter 
docker run --rm -it --entrypoint /bin/bash --name packages packages 
```

### Multistage

```sh
# NOT WORKING
docker buildx build --progress=plain --target PACKAGES -f Dockerfile -t multistage --build-context context2=../context2 --build-context packages=../packages .
```

## Resource

* Dockerfiles now Support Multiple Build Contexts [here](https://www.docker.com/blog/dockerfiles-now-support-multiple-build-contexts/)
* 3 interesting ways to use the Linux cowsay command [here](https://opensource.com/article/21/11/linux-cowsay-command)

