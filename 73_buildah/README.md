# Buildah

Demonstrate how to use buildah (linux only).  

NOTE: On MacOS it's best to install into a vagrant VM.  

TODO:

* create a buildah in docker image
* modify images with buildah

```sh
# requires at least ubuntu 20.10
sudo apt-get -y update
sudo apt-get -y install buildah
```

```sh
# look if rootless is true
buildah info
```

## Build an image

```sh
# build
buildah build -t buildahtest    

# push over into docker 
buildah push buildahtest docker-daemon:buildahtest2:latest

# run the image
docker run -it buildahtest2  
```

## Resources

* buildah.io [here](https://buildah.io/)
* Installation instructions [here](https://github.com/containers/buildah/blob/main/install.md)
* Tutorial [here](https://github.com/containers/buildah/tree/main/docs/tutorials)
* Dockerless, part 1: Which tools to replace Docker with and why [here](https://mkdev.me/posts/dockerless-part-1-which-tools-to-replace-docker-with-and-why)
* Rootless tutorial [here](https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md)
