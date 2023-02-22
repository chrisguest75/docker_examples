# BUILDERS

Demonstrate how to use builders.  

TODO:

* Is it easier to control diskspace and intermediate images?
* Can you build with images accross builders?
* why did I have to pull nix image first on containerd?
* dive does not work with containerd?

## Reason


## Create

```sh
docker buildx version

docker buildx create --use --driver docker-container --driver-opt network=host --name buildtest --platform linux/arm64
```

### FFMPEG

```bash
export BASEIMAGE=scratch
export BASEIMAGE=gcr.io/distroless/nodejs16-debian11
# ffmpeg (have to use --load to retain in image cache)
docker buildx build --load --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t nix-ffmpeg .

docker buildx build --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t nix-ffmpeg --output type=image,name=nix-ffmpeg,oci-mediatypes=true,compression=zstd,compression-level=3,force-compression=true,push=true .



docker run --rm -it nix-ffmpeg --version       

dive nix-ffmpeg
```

## Cleaning up

```sh
docker buildx rm 
```


## Resources

https://docs.docker.com/engine/reference/commandline/buildx_create/

https://github.com/moby/buildkit/blob/master/docs/buildkitd.toml.md

https://docs.docker.com/build/buildkit/toml-configuration/

