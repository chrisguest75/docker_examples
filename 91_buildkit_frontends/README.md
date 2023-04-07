# FRONTENDS

Demonstrate how to use `docker frontends`.  

## Reason

BuildKit is a toolkit for converting source code into build artifacts, such as executable files or Docker images, in an efficient, concurrent, and cache-friendly manner. It is primarily used as the backend for building Docker images, but it can also be used independently.  

BuildKit frontends are the components that define how BuildKit should interpret and process the build instructions. These frontends parse build files (such as Dockerfiles) and translate them into a format that BuildKit's core can understand, known as the intermediate representation (IR). The IR is a lower-level format that represents the build graph, which BuildKit's core uses to execute the build process.  

There are different frontends available for BuildKit, each catering to different build systems or languages. Some examples of BuildKit frontends are:  

* Dockerfile frontend (dockerfile.v0): This is the default frontend for BuildKit and is designed to process Dockerfiles. It understands Dockerfile syntax and translates it into a format that BuildKit can use.  

* LLB (Low-Level Builder) frontend (gateway.v0): This frontend is for those who want more control over the build process than what Dockerfiles can provide. It allows users to define the build graph using the LLB format directly, which is the same format that BuildKit uses internally. This provides more flexibility and finer control over the build process.  

* Custom frontends: Users can create their own custom frontends to handle specific build systems, languages, or other unique requirements. These frontends can be written in any language, as long as they can communicate with BuildKit's core using gRPC.  

Frontends play a crucial role in BuildKit's architecture, as they allow it to be flexible and support a wide range of build systems, making it a versatile tool for developers.  

## Examples

Examples here are based on other examples.  

* HereDocs [here](../60_heredocs/README.md)  
* Buildpacks [here](../43_python_buildpacks/README.md)  
* Multiarchitecture [here](../55_multiarch/README.md)  
* Builders [here](../90_builders/README.md)  

## Build (dockerfile)

### Add checksums

Based on buildkit frontend [1.5.0 release](https://github.com/moby/buildkit/releases/tag/dockerfile%2F1.5.0-labs).  `ADD` now supports a checksum.  

```sh
# download a file with a checksum
docker buildx build --progress=plain -f Dockerfile.addchecksum -t addchecksum .
# check it exists
dive addchecksum
```

### FROM arch

You can override the architecture in the docker file.  
Using this technique you can use an AMD64 build to build some tooling or config for an ARM64 final image.  

```sh
docker buildx build --progress=plain -f Dockerfile.mixedarch -t mixedarch .
# examine output and see ARM64 and AMD64 strings coming from different architectures
docker run -it mixedarch
```

## Build (flakes.nix)

Using a frontend that builds `flakes.nix` directly into an image.  This creates an images that has a reproducible hash.  

```sh
docker system prune --all --force
# looks like the file has to be called flake.nix
docker buildx build -t nginx-nix -f ./flake.nix .
docker run -it -p 8080:80 --rm --name nginx-nix nginx-nix
curl http://localhost:8080 

docker images --digests
```

```log
nginx-nix latest 94727237fecd 53 years ago 135MB
```

Quick demo of non-reproducible builds with docker containers.  

```sh
# create a new builder 
# NOTE: You can check buildkit in cli https://github.com/docker/cli/blob/master/vendor.mod or vendor.conf depending on commitid in docker version
docker buildx create --use --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.5 --name test1 --platform linux/amd64
# create a second builder
docker buildx create --use --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.5 --name test2 --platform linux/amd64

docker buildx ls

export BASEIMAGE=scratch
# even with timestamp removal it still isn't same hash.  
SOURCE_DATE_EPOCH=0 docker buildx build --builder test1 --platform linux/amd64 --load --build-arg=baseimage=$BASEIMAGE --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t ffmpeg-test1 .
SOURCE_DATE_EPOCH=0 docker buildx build --builder test2 --platform linux/amd64 --load --build-arg=baseimage=$BASEIMAGE --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t ffmpeg-test2 .
```

The same build produces different SHA.  

```sh
docker images --digests

> ffmpeg-test2 latest <none> 1646a702dff0 About a minute ago   153MB
> ffmpeg-test1 latest <none> 994057e9efdf 5 minutes ago        153MB
```

## Resources

* Dockerfile frontend syntaxes [here](https://github.com/moby/buildkit/blob/dockerfile/1.4.0/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link)  
* Dockerhub BuildKit Dockerfile frontend [here](https://hub.docker.com/r/docker/dockerfile)
* Custom Dockerfile syntax [here](https://docs.docker.com/build/buildkit/dockerfile-frontend/)
* Demystifying the Buildpacks frontend for BuildKit [here](https://shemleong.medium.com/demystifying-the-buildpacks-buildkit-frontend-6e9378001c6c)  
* nginx reproducible-containers/buildkit-nix [here](https://github.com/reproducible-containers/buildkit-nix/blob/master/examples/nginx-flake/flake.nix)  
* dockerhub docker/dockerfile-upstream [here](https://hub.docker.com/r/docker/dockerfile-upstream)
* Exploring LLB [here](https://github.com/moby/buildkit#exploring-llb)
* envd (ɪnˈvdɪ) is a command-line tool that helps you create the container-based development environment for AI/ML. [here](https://github.com/tensorchord/envd/)  
* Concurrent, Cache-efficient, and Dockerfile-agnostic Builder toolkit [here](https://morioh.com/p/274c9a97e133)
* Install Docker Buildx [here](https://docs.docker.com/build/install-buildx/)  
* Capturing Build Information with BuildKit [here](https://www.docker.com/blog/capturing-build-information-buildkit/)  
* 