# README

Demonstrate using multiple build contexts.  

## Reason

Multi contexts allow us to provide multiple sources into a single image. It allows us to get the benefits of multistage builds without having to use a single Dockerfile.  

## Build

```sh
cd ./context1
```

### Single context

Standard single context builds.  

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

Dual context builds.  

```sh
# build
docker buildx build --target BASE -f Dockerfile.dual -t context2 --build-context context2=../context2 .

# run cowsay and see message comes from 2nd context
docker run --rm -it --name context2 context2  

# enter 
docker run --rm -it --entrypoint /bin/bash --name context2 context2

> ls
```

### Packages

Add a third packages context.  

```sh
docker buildx build -f Dockerfile.packages -t packages --build-context context2=../context2 --build-context packages=../packages .

# run cowsay
docker run --rm -it --name packages packages  

# enter and see the packages copied into the folder
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
# modify ../context2/.dockerignore and ./Dockerfile.ignore.dockerignore
docker buildx build --no-cache -f Dockerfile.ignore -t ignore --build-context context2=../context2 .
```

### Docker image context

Using images as contexts.  

```sh
# build image to be used as context
docker buildx build --target BASE -f Dockerfile.imagecontext -t imagecontext .

# build using image as a context
docker buildx build --target BASE -f Dockerfile.useimagecontext -t useimagecontext --build-context imagecontext=docker-image://imagecontext .

# use the script from the imagecontext
docker run --rm -it --name useimagecontext useimagecontext  
```

## Resource

* Dockerfiles now Support Multiple Build Contexts [here](https://www.docker.com/blog/dockerfiles-now-support-multiple-build-contexts/)  
* 3 interesting ways to use the Linux cowsay command [here](https://opensource.com/article/21/11/linux-cowsay-command)  
