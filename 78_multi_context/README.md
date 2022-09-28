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

Multistage works as well.  

NOTE: We need to be careful about names of stages and contexts sharing names.  

```sh
docker buildx build --target base --progress=plain -f Dockerfile.multistage -t multistage --build-context context2=../context2 --build-context packages=../packages .

# run cowsay
docker run --rm -it --name multistage multistage  

docker buildx build --target packagesstage --progress=plain -f Dockerfile.multistage -t multistage --build-context context2=../context2 --build-context packages=../packages .

# run cowsay
docker run --rm -it --name multistage multistage  
```

### Dual context (dockerignore)

Each context has a .dockerignore.  

```sh
# build (should fail, need to modify the dockerignore files)
docker buildx build -f Dockerfile.ignore -t ignore --build-context context2=../context2 .
```

## Resource

* Dockerfiles now Support Multiple Build Contexts [here](https://www.docker.com/blog/dockerfiles-now-support-multiple-build-contexts/)
* 3 interesting ways to use the Linux cowsay command [here](https://opensource.com/article/21/11/linux-cowsay-command)
