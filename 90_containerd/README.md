# CONTAINERD

Demonstrate how to use `dontainerd`  

TODO:

* dive does not work with containerd.  Why is this?
* 

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
```

## nerdctl

```sh
brew install nerdctl
```

## Resources

* ctr - Man Page [here](https://www.mankier.com/8/ctr)
* nerdctl: Docker-compatible CLI for containerd [here](https://github.com/containerd/nerdctl)  
* Getting started with containerd [here](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
* runc is a CLI tool for spawning and running containers on Linux according to the OCI specification. [here](https://github.com/opencontainers/runc)  
* Why and How to Use containerd From Command Line [here](https://iximiuz.com/en/posts/containerd-command-line-clients/)
