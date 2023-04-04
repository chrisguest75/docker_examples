# CONTAINERD

Demonstrate how to use `containerd`  

TODO:

* dive does not work with containerd.  Why is this?
* Get Estargz compression working on linux 
https://www.usenix.org/system/files/conference/fast16/fast16-papers-harter.pdf 
https://link.medium.com/Jl8qGEQPGyb 
https://github.com/containerd/stargz-snapshotter/issues/258 
* https://github.com/containerd/stargz-snapshotter/blob/main/docs/ctr-remote.md 

## Install Docker Desktop

On MacOS Docker Desktop it is possible to set docker to use containerd as the default backend.  

## Install Ubuntu

```sh
# install docker prereqs
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# check containerd is running
sudo systemctl status containerd

# ctr will be installed
ctr 
ctr plugins ls


# run nginx
docker run -d -p 8080:80 nginx  

# docker
docker ps
# runc
runc list
# containerd
sudo ctr containers ls   
sudo ctr namespaces ls   
sudo ctr --namespace moby containers ls 
sudo ctr --namespace moby containers info 0a5ef6d3a499e420c00692ac04cfe84fbc5f1d96ebde8bf4765c0f5f3c9088dd


sudo /home/linuxbrew/.linuxbrew/bin/nerdctl ps 

dockerd --help

# it looks like it is running containerd sock
ps -aux | grep dockerd          
```

## nerdctl

```sh
# on linux or mac
brew install nerdctl
```

## Resources

* ctr - Man Page [here](https://www.mankier.com/8/ctr)
* nerdctl: Docker-compatible CLI for containerd [here](https://github.com/containerd/nerdctl)  
* Getting started with containerd [here](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
* runc is a CLI tool for spawning and running containers on Linux according to the OCI specification. [here](https://github.com/opencontainers/runc)  
* Why and How to Use containerd From Command Line [here](https://iximiuz.com/en/posts/containerd-command-line-clients/)
* Extending Docker’s Integration with containerd [here](https://www.docker.com/blog/extending-docker-integration-with-containerd/)

https://docs.docker.com/engine/reference/commandline/dockerd/