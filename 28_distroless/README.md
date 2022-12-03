# README

Demonstrate Distroless containers where the shell is removed.  

Other examples:  

* nix-examples/09_distroless [here](https://github.com/chrisguest75/nix-examples/tree/master/09_distroless)  
* typescript_examples/26_jobserver [here](https://github.com/chrisguest75/typescript_examples/blob/master/26_jobserver/Dockerfile)  

## 🏠 Build example

We have different versions of nodejs available to us.  

```sh
# node14
docker build --no-cache -f v14.Dockerfile -t v14_distroless .
docker run -it --rm v14_distroless  

# node16 (override image)
docker build --no-cache -f v16.Dockerfile -t v16_distroless .
docker run -it --rm v16_distroless  
```

## 🏠 Build debug example for shell

If you need access to a shell to enter the container then add `-debug`  

```sh
docker build --no-cache -f v14-debug.Dockerfile -t v14_distroless_debug .
docker run -it --rm v14_distroless_debug  

# Get onto the container
docker run -it --rm --entrypoint /busybox/sh v14_distroless_debug
```

Or override the base image that we're using to be the debug ones.  

```sh
# Pass in the image technique - node16 (override image)
docker build --build-arg DISTROLESS_BASEIMAGE="gcr.io/distroless/nodejs16-debian11:debug" --no-cache -f v16.Dockerfile -t v16_distroless_debug .

# use /busybox/sh
docker run -it --entrypoint /busybox/sh --rm v16_distroless_debug   
id 
cat /etc/passwd

docker run -it --user root --entrypoint /busybox/sh --rm v16_distroless-debug   
id
```

## 🏠 Single step debugging (vscode)

```sh
# enter the directory for the vscode settings.  
cd ./28_distroless
docker run -it --rm -p 9229:9229 v16_distroless --inspect-brk=0.0.0.0:9229 index.js
```

## 🏠 Upgrade to Node12

```sh
docker build --no-cache -f distroless_node12.Dockerfile -t distroless-build .

docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm distroless-build  
```

Debug  

```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm --entrypoint /bin/bash distroless-build  

# Run this inside the container
bazel run //experimental/nodejs --verbose_failures --sandbox_debug  
```

## 🔍 Docker Scan (vulnerability scanning)

```sh
# scan v14
docker scan v14_distroless  

# scan v16
docker scan v16_distroless  

# scan debug
docker scan v16_distroless-debug  
```

## Users

```sh
# Pass in the image technique - node16 (override image)
docker build --build-arg DISTROLESS_BASEIMAGE="gcr.io/distroless/nodejs16-debian11:debug" --no-cache -f v16.Dockerfile -t v16_distroless-debug .
# use /busybox/sh
docker run -it --entrypoint /busybox/sh --rm v16_distroless-debug   
id user

docker run -it --user root --entrypoint /busybox/sh --rm v16_distroless   
id user

# nonroot user
docker build --build-arg DISTROLESS_BASEIMAGE="gcr.io/distroless/nodejs16-debian11:debug-nonroot" --no-cache -f v16_nonroot.Dockerfile -t v16_debian_distroless_nonroot .
docker run -it --rm v16_debian_distroless_nonroot   

docker run -it --entrypoint /busybox/sh --rm v16_debian_distroless_nonroot   
id user

```

## Demo

```sh
# build it
docker build --no-cache -f v16.Dockerfile -t v16_distroless .
docker run -it --rm v16_distroless  

# pull slim
docker pull node:16-bullseye-slim

# size 
docker images node:16-bullseye-slim 
docker images v16_distroless  

# dive into it
dive v16_distroless 

# compare layers and sizes
dive node:16-bullseye-slim
```

## 👀 Resources

* Distroless repo [here](https://github.com/GoogleContainerTools/distroless)  
* Node build tags [here](https://github.com/GoogleContainerTools/distroless/blob/main/nodejs/README.md)  
* NodeJS bestpractices [here](https://snyk.io/wp-content/uploads/10-best-practices-to-containerize-Node.js-web-applications-with-Docker.pdf)  
* Debugging Guide[here](https://nodejs.org/en/docs/guides/debugging-getting-started/)  
* Node.js debugging in VS Code [here](https://code.visualstudio.com/docs/nodejs/nodejs-debugging)
* What's Inside Of a Distroless Container Image: Taking a Deeper Look [help](https://iximiuz.com/en/posts/containers-distroless-images/)
* Publish :nonroot versions of images [here](https://github.com/GoogleContainerTools/distroless/issues/306)
* Using unprivileged users [here](https://github.com/GoogleContainerTools/distroless/issues/277)
