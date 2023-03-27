# METADATA

Demonstrate how the metadata output file works.  

REF: Examples pulled from [90_builders/README.md](../90_builders/README.md)  

NOTES:

* You can specify the version of buildkit when creating builder.  
* Docker desktop is quite far behind on buildkit version.  

TODO:

* Why is the buildkit version not included in the metadata?  

## Reason

As part of the push for SBOM a metadata output can be specified to list some source build information.  

## Create builders

```sh
# list current builders
docker buildx ls 

# list version of plugin
docker buildx version

# create a new builder with a specific version of buildkit
docker buildx create --use --bootstrap --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.2 --name buildtest_amd64 --platform linux/amd64

# once created the build-kit containers are running 
docker ps

# version 
docker buildx ls 
```

### FFMPEG (metadata.json)

Building ffmpeg using nix in different architectures on different builders.  

```bash
# with shell
export BASEIMAGE=gcr.io/distroless/nodejs16-debian11:debug
export BASEIMAGE=ubuntu:20.04
```

### x86 build of ffmpeg

```bash
# ffmpeg (have to use --load to retain in image cache)
docker buildx build --builder buildtest_amd64 --platform linux/amd64 --load --build-arg=baseimage=$BASEIMAGE --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION --metadata-file metadata.json -t nix-ffmpeg-amd64 .

# show version and arch
docker run --rm -it nix-ffmpeg-amd64 -version
docker run --rm -it --entrypoint /usr/bin/show_architecture.sh nix-ffmpeg-amd64 

docker images
dive nix-ffmpeg-amd64 
```

## Cleaning up

```sh
docker buildx rm buildtest_amd64
```

## Resources

* Capturing Build Information with BuildKit [here](https://www.docker.com/blog/capturing-build-information-buildkit/)  
* moby/buildkit [here](https://github.com/moby/buildkit)  
* First impressions and learnings on the new BuildKit's supply chain security features [here](https://www.felipecruz.es/buildkit-supply-chain-features/)  
