# NERDCTL

Demonstrate how to use `nerdctl`  

## Install

```sh
# on linux or mac
brew install nerdctl
```


```sh
# build normal
docker buildx build  --platform linux/amd64 --load --progress=plain -f Dockerfile.ffmpeg -t ffmpeg .

# run
docker run --rm -it ffmpeg 
```

```sh
# needs rootless
nerdctl buildx build  --platform linux/amd64 --load --progress=plain -f Dockerfile.ffmpeg -t ffmpeg .
```

## Resources

* nerdctl: Docker-compatible CLI for containerd [here](https://github.com/containerd/nerdctl)  
* Lazy-pulling using Stargz Snapshotter [here](https://github.com/containerd/nerdctl/blob/main/docs/stargz.md)  

https://github.com/containerd/nerdctl/blob/main/docs/rootless.md