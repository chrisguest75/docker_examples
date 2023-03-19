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

```sh
docker buildx build --progress=plain -f Dockerfile.addchecksum -t addchecksum .

dive addchecksum
```

### FROM arch

```sh
```

## Build (flakes.nix)

NOTE: This is not working yet.  

```sh
# looks like the file has to be called flake.nix
docker buildx build -t nginx-nix -f ./flake.nix .
```

```log
nginx-nix                  latest            45caff172034   53 years ago     135MB
```

```sh
docker run -d -p 8080:80 --read-only --name nginx-nix nginx-nix
```

## Resources

* Dockerfile frontend syntaxes [here](https://github.com/moby/buildkit/blob/dockerfile/1.4.0/frontend/dockerfile/docs/syntax.md#linked-copies-copy---link-add---link)  
* Dockerhub BuildKit Dockerfile frontend [here](https://hub.docker.com/r/docker/dockerfile)
* Custom Dockerfile syntax [here](https://docs.docker.com/build/buildkit/dockerfile-frontend/)
* Demystifying the Buildpacks frontend for BuildKit [here](https://shemleong.medium.com/demystifying-the-buildpacks-buildkit-frontend-6e9378001c6c)  

https://hub.docker.com/r/docker/dockerfile-upstream

https://github.com/moby/buildkit#exploring-llb
https://github.com/reproducible-containers/buildkit-nix

https://github.com/tensorchord/envd/

https://github.com/reproducible-containers/buildkit-nix/tree/master/examples/golang-httpserver-flake

https://github.com/reproducible-containers/buildkit-nix/blob/master/examples/nginx-flake/flake.nix

