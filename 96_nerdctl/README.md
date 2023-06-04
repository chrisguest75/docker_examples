# NERDCTL

Demonstrate how to use `nerdctl`  

## Install

```sh
# on linux or mac
brew install nerdctl

# v1.4.0
nerdctl --version 

which nerdctl
```

## Building

```sh
# build normal
docker buildx build  --platform linux/amd64 --load --progress=plain -f Dockerfile.ffmpeg -t ffmpeg .

# run
docker run --rm -it ffmpeg 
```

```sh
# needs rootless
nerdctl buildx build  --platform linux/amd64 --load --progress=plain -f Dockerfile.ffmpeg -t ffmpeg .

# requires buildctl and buildkitd (using linuxbrew)
sudo /home/linuxbrew/.linuxbrew/bin/nerdctl build --progress=plain -f Dockerfile.ffmpeg -t ffmpeg .

brew install buildkit
```

## Resources

* nerdctl: Docker-compatible CLI for containerd [here](https://github.com/containerd/nerdctl)  
* Lazy-pulling using Stargz Snapshotter [here](https://github.com/containerd/nerdctl/blob/main/docs/stargz.md)  

https://github.com/containerd/nerdctl/blob/main/docs/rootless.md

https://github.com/moby/buildkit

