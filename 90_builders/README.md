# BUILDERS

Demonstrate how to use docker builders.  

NOTES:

* Demonstrate building different architectures with different builders
* Realise there is issue building ARM Nix packages (it's needs an override for ebpf).  
* There is no caching between builders.  
* If you're using a builder you'll need to use --push or --load. The default docker builder does not need the extra parameters. But it does work with them.  
* A default builder always pulls latest buildkit over the embedded docker desktop one.  

TODO:

* Is it easier to control diskspace and intermediate images?
* Can you build with images accross builders?
* why did I have to pull nix image first on containerd?
* dive does not work with containerd?

## Reason

BuildKit is an improved backend to replace the legacy builder. It comes with new and much improved functionality for improving your builds’ performance and the reusability of your Dockerfiles. It also introduces support for handling more complex scenarios:  

* Detect and skip executing unused build stages
* Parallelize building independent build stages
* Incrementally transfer only the changed files in your build context between builds
* Detect and skip transferring unused files in your build context
* Use Dockerfile frontend implementations with many new features
* Avoid side effects with rest of the API (intermediate images and containers)
* Prioritize your build cache for automatic pruning

NOTE: Buildx always enables BuildKit.  

## Create builders

```sh
# list current builders
docker buildx ls 

# list version of plugin
docker buildx version

# create a new builder 
# NOTE: You can check buildkit in cli https://github.com/docker/cli/blob/master/vendor.mod or vendor.conf depending on commitid in docker version
docker buildx create --use --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.5 --name buildtest_arm64 --platform linux/arm64
# create a second builder
docker buildx create --use --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.5 --name buildtest_amd64 --platform linux/amd64

# once created the build-kit containers are running 
docker ps
# you can get the arch of each image being used
docker exec -it buildx_buildkit_buildtest_arm640 /bin/arch
```

### Processor

This just builds a container that prints out CPU Arch details REF: [55_multiarch](../55_multiarch/README.md).  

```bash
docker buildx build --builder buildtest_amd64 --platform linux/amd64 --load --progress=plain -f Dockerfile.processor -t processor-amd64 .

docker run --rm -it processor-amd64 

docker buildx build --builder buildtest_arm64 --platform linux/arm64 --load --progress=plain -f Dockerfile.processor -t processor-arm64 .

docker run --rm -it processor-arm64 
```

### FFMPEG

Building ffmpeg using nix in different architectures on different builders.  

```bash
export BASEIMAGE=scratch
export BASEIMAGE=gcr.io/distroless/nodejs16-debian11
# with shell
export BASEIMAGE=gcr.io/distroless/nodejs16-debian11:debug
export BASEIMAGE=ubuntu:20.04
```

### x86 build of ffmpeg

```bash
# ffmpeg (have to use --load to retain in image cache)
docker buildx build --builder buildtest_amd64 --platform linux/amd64 --load --build-arg=baseimage=$BASEIMAGE --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t nix-ffmpeg-amd64 .

# show version and arch
docker run --rm -it nix-ffmpeg-amd64 -version
docker run --rm -it --entrypoint /usr/bin/show_architecture.sh nix-ffmpeg-amd64 

docker images
dive nix-ffmpeg-amd64 
```

### ARM build of ffmpeg

NOTE: This has a seccomp issue.  

```bash
docker buildx build --builder buildtest_arm64 --platform linux/arm64 --load --build-arg=baseimage=$BASEIMAGE --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t nix-ffmpeg-arm64 .

# show version and arch
docker run --platform linux/arm64 --rm -it nix-ffmpeg-arm64 -version
docker run --platform linux/arm64 --rm -it --entrypoint /usr/bin/show_architecture.sh nix-ffmpeg-arm64 

docker images
dive nix-ffmpeg-arm64 
```

## Third builder (test caching)

```sh
# create a second builder
docker buildx create --use --driver docker-container --driver-opt network=host --name buildtest_amd64_2 --platform linux/amd64

# using a different builder will mean the image is not cached.  
docker buildx build --builder buildtest_amd64_2 --platform linux/amd64 --load --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t nix-ffmpeg-amd64_2 .
```

## Cleaning up

```sh
docker buildx rm buildtest_amd64
docker buildx rm buildtest_arm64
docker buildx rm buildtest_amd64_2
```

## Resources

* docker buildx create - Create a new builder instance [here](https://docs.docker.com/engine/reference/commandline/buildx_create/)  
* buildkit/docs/buildkitd.toml.md [here](https://github.com/moby/buildkit/blob/master/docs/buildkitd.toml.md)  
* BuildKit TOML configuration [here](https://docs.docker.com/build/buildkit/toml-configuration/)  
* moby/buildkit repo [here](https://github.com/moby/buildkit)  
* Cross Compilation failing with Nix and Docker on MacOS [here](https://discourse.nixos.org/t/cross-compilation-failing-with-nix-and-docker-on-macos/22169/4)  
* How to check the default buildkit version? [here](https://stackoverflow.com/questions/71374671/how-to-check-the-default-buildkit-version)  
