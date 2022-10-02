# README

Demonstrate how to use `bake` to build multiple images.  

REF: Nix 09_distroless [here](https://github.com/chrisguest75/nix-examples/blob/master/09_distroless/README.md)  

## Bake

```bash
# use bake to build all the images
docker buildx bake --metadata-file ./bake-metadata.json  
docker buildx bake --metadata-file ./bake-metadata.json --no-cache 

while IFS=, read -r imagesha
do
    echo "IMAGE:$imagesha"
    docker run --rm -t "$imagesha" --version
done < <(jq -r '. | keys[] as $key | .[$key]."containerimage.digest"' ./bake-metadata.json)
```

## Resources

* docker buildx bake [here](https://docs.docker.com/engine/reference/commandline/buildx_bake/)
* User defined HCL functions [here](https://docs.docker.com/build/customize/bake/hcl-funcs/)
* High-level build options with Bake [here](https://docs.docker.com/build/customize/bake/)
* buildx repo [here](https://github.com/docker/buildx)
* Bake your Container Images with Bake [here](https://blog.kubesimplify.com/bake-your-container-images-with-bake)
* developer-guy/hello-world-buildx repo [here](https://github.com/developer-guy/hello-world-buildx)
