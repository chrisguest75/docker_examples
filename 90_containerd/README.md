# CONTAINERD

Demonstrate how to use `containerd`  

TODO:

* firecracker can be containerd plugin
* dive does not work with containerd.  Why is this?
* Get Estargz compression working on linux 
https://www.usenix.org/system/files/conference/fast16/fast16-papers-harter.pdf 
https://link.medium.com/Jl8qGEQPGyb 
https://github.com/containerd/stargz-snapshotter/issues/258 
* https://github.com/containerd/stargz-snapshotter/blob/main/docs/ctr-remote.md 
* https://github.com/containerd/containerd/blob/main/docs/rootless.md


https://github.com/containerd/stargz-snapshotter/blob/main/docs/INSTALL.md
Checked vendor/modules.txt to see what version was included
https://github.com/moby/moby/tree/219f21bf07502b447095649b5a2764661737f164

https://github.com/containerd/stargz-snapshotter/blob/main/docs/overview.md

https://manpages.ubuntu.com/manpages/jammy/man8/mount.fuse.8.html

## Install Docker Desktop

On MacOS Docker Desktop it is possible to set docker to use containerd as the default backend.  

## Install Ubuntu

```sh
# install docker prereqs
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# check containerd is running
sudo systemctl status containerd

# ctr will be installed
sudo ctr version     

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

## Configuration

```sh
cat /etc/docker/daemon.json
cat /etc/containerd/config.toml  
cat /etc/containerd-stargz-grpc/config.toml 


```


## Plugins

Instructions for installing estargz snapshotter [here](https://github.com/containerd/stargz-snapshotter/blob/main/docs/INSTALL.md)  
https://github.com/containerd/stargz-snapshotter/blob/main/script/config/etc/containerd/config.toml

```sh
sudo nano /etc/docker/daemon.json
sudo nano /etc/containerd/config.toml  

# list plugins
sudo ctr plugins ls  
```

```sh
version=v0.14.3
arch=amd64
# GET THE CORRECT SYNTAX
# curl -l -o stargz-snapshotter-${version}-linux-${arch}.tar.gz https://github.com/containerd/stargz-snapshotter/releases/download/${version}/stargz-snapshotter-${version}-linux-${arch}.tar.gz

sudo -s  

tar -C /usr/local/bin -xvf stargz-snapshotter-${version}-linux-${arch}.tar.gz containerd-stargz-grpc ctr-remote
wget -O /etc/systemd/system/stargz-snapshotter.service https://raw.githubusercontent.com/containerd/stargz-snapshotter/${version}/script/config/etc/systemd/system/stargz-snapshotter.service
systemctl enable --now stargz-snapshotter
systemctl restart containerd
systemctl restart docker

```
https://github.com/containerd/stargz-snapshotter/releases


```ini
[Unit]
Description=stargz snapshotter
After=network.target
Before=containerd.service

[Service]
Type=notify
Environment=HOME=/root
ExecStart=/usr/local/bin/containerd-stargz-grpc --log-level=debug --config=/etc/containerd-stargz-grpc/config.toml
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
```

```toml
# explicitly use v2 config format
version = 2

# - Set default runtime handler to v2, which has a per-pod shim
# - Enable to use stargz snapshotter
[plugins."io.containerd.grpc.v1.cri".containerd]
  default_runtime_name = "runc"
  snapshotter = "stargz"
  disable_snapshot_annotations = false
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  runtime_type = "io.containerd.runc.v2"

# Setup a runtime with the magic name ("test-handler") used for Kubernetes
# runtime class tests ...
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.test-handler]
  runtime_type = "io.containerd.runc.v2"

# Use stargz snapshotter
[proxy_plugins]
  [proxy_plugins.stargz]
    type = "snapshot"
    address = "/run/containerd-stargz-grpc/containerd-stargz-grpc.sock"
```

journalctl -xeu stargz-snapshotter.service   

sudo /usr/local/bin/containerd-stargz-grpc                                                                                                                  0.06     07:52    1.44G 
{"error":"failed to mount overlay: invalid argument","level":"fatal","msg":"snapshotter is not supported","time":"2023-04-08T19:53:06.916442927+01:00"}

# it seems to create this folder.
sudo ls -la /var/lib/containerd-stargz-grpc/snapshotter    

sudo strace /usr/local/bin/containerd-stargz-grpc   


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

https://medium.com/nttlabs/startup-containers-in-lightning-speed-with-lazy-image-distribution-on-containerd-243d94522361

https://www.tutorialworks.com/difference-docker-containerd-runc-crio-oci/?utm_content=cmp-true

https://docs.docker.com/engine/install/linux-postinstall/