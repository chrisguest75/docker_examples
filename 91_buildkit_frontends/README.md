# FRONTENDS

Demonstrate how to use `docker frontends`.  

TODO:

* Link to the buildpacks example.  

## Reason

BuildKit is a toolkit for converting source code into build artifacts, such as executable files or Docker images, in an efficient, concurrent, and cache-friendly manner. It is primarily used as the backend for building Docker images, but it can also be used independently.  

BuildKit frontends are the components that define how BuildKit should interpret and process the build instructions. These frontends parse build files (such as Dockerfiles) and translate them into a format that BuildKit's core can understand, known as the intermediate representation (IR). The IR is a lower-level format that represents the build graph, which BuildKit's core uses to execute the build process.  

There are different frontends available for BuildKit, each catering to different build systems or languages. Some examples of BuildKit frontends are:  

* Dockerfile frontend (dockerfile.v0): This is the default frontend for BuildKit and is designed to process Dockerfiles. It understands Dockerfile syntax and translates it into a format that BuildKit can use.  

* LLB (Low-Level Builder) frontend (gateway.v0): This frontend is for those who want more control over the build process than what Dockerfiles can provide. It allows users to define the build graph using the LLB format directly, which is the same format that BuildKit uses internally. This provides more flexibility and finer control over the build process.  

* Custom frontends: Users can create their own custom frontends to handle specific build systems, languages, or other unique requirements. These frontends can be written in any language, as long as they can communicate with BuildKit's core using gRPC.  

Frontends play a crucial role in BuildKit's architecture, as they allow it to be flexible and support a wide range of build systems, making it a versatile tool for developers.  

## Examples

* HereDocs [here](../60_heredocs/README.md)  

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

Using a frontend that builds `flakes.nix` directly into an image.  This creates 

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

## Resources

* Dockerfile frontend syntaxes [here](https://github.com/moby/buildkit/blob/dockerfile/1.4.0/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link)  
* Dockerhub BuildKit Dockerfile frontend [here](https://hub.docker.com/r/docker/dockerfile)
* Custom Dockerfile syntax [here](https://docs.docker.com/build/buildkit/dockerfile-frontend/)
* Demystifying the Buildpacks frontend for BuildKit [here](https://shemleong.medium.com/demystifying-the-buildpacks-buildkit-frontend-6e9378001c6c)  
* nginx reproducible-containers/buildkit-nix [here](https://github.com/reproducible-containers/buildkit-nix/blob/master/examples/nginx-flake/flake.nix)  
* dockerhub docker/dockerfile-upstream [here](https://hub.docker.com/r/docker/dockerfile-upstream)
* Exploring LLB [here](https://github.com/moby/buildkit#exploring-llb)
* envd (ɪnˈvdɪ) is a command-line tool that helps you create the container-based development environment for AI/ML. [here](https://github.com/tensorchord/envd/)  

https://github.com/reproducible-containers/buildkit-nix