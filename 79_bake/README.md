# README

Demonstrate how to use `bake` to build multiple images.  

REF: Nix 09_distroless [here](https://github.com/chrisguest75/nix-examples/blob/master/09_distroless/README.md)  

## Reason

Bake gives us the ability to create images and their dependencies. This allows us to build for multiple target architectures or build an intermediate image and copy the results into a final image.  

## Bake

```bash
# use bake to build all the images
docker buildx bake -f docker-bake.hcl --metadata-file ./bake-metadata.json  
docker buildx bake -f docker-bake.hcl --metadata-file ./bake-metadata.json --no-cache 
# override image name
DISTROLESS="gcr.io/distroless/nodejs:16-debug" docker buildx bake -f docker-bake.hcl --metadata-file ./bake-metadata.json

while IFS=, read -r imagesha
do
    echo "IMAGE:$imagesha"
    docker run --rm -t "$imagesha"
done < <(jq -r '. | keys[] as $key | .[$key]."containerimage.digest"' ./bake-metadata.json)
```

## Chained Bake

A chained bake uses a built image to build another image.  
Here I build a `jq` scratch image and share it into ubuntu to copy the contents.  

```sh
docker buildx bake -f ./docker-bake-chained.hcl --print final

# build the image
docker buildx bake -f docker-bake-chained.hcl --metadata-file ./bake-metadata.json  

# set it up to use docker image context. 
docker run --rm -t jq-ubuntu-final

# look at the base container
dive jq-base-scratch

# look at the base container
dive jq-ubuntu-final
```

## Resources

* docker buildx bake [here](https://docs.docker.com/engine/reference/commandline/buildx_bake/)
* User defined HCL functions [here](https://docs.docker.com/build/customize/bake/hcl-funcs/)
* High-level build options with Bake [here](https://docs.docker.com/build/customize/bake/)
* buildx repo [here](https://github.com/docker/buildx)
* Bake your Container Images with Bake [here](https://blog.kubesimplify.com/bake-your-container-images-with-bake)
* developer-guy/hello-world-buildx repo [here](https://github.com/developer-guy/hello-world-buildx)
* ffmpeg nix file [here](https://github.com/NixOS/nixpkgs/blob/nixos-22.05/pkgs/development/libraries/ffmpeg/generic.nix#L230)