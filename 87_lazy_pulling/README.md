# LAZY PULLING

Demonstrate how to control buildkit to build images ordered for lazy pulls.  

TODO:

* ctr
* nerdctl
* does slim ai use it?

## Reason 

Lazy pulling is a container deployment strategy that is used to improve the efficiency of container image downloads. Rather than downloading an entire container image upfront, lazy pulling only downloads the layers of the image that are needed at runtime. This can help reduce the time and bandwidth required to deploy a container, particularly for large or complex images.  

## Check containerd

```sh
# are we running containerd?
docker info
```

## Default Compression (161MB)

```bash
export BASEIMAGE=scratch
#export BASEIMAGE=gcr.io/distroless/nodejs16-debian11
export IMAGE_NAME_DEFAULT=ttl.sh/$(uuidgen):1h
export IMAGE_NAME_DEFAULT=${IMAGE_NAME_DEFAULT:l}

# default compression
docker build --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION -t ${IMAGE_NAME_DEFAULT} .

docker images

docker run --rm -it $IMAGE_NAME_DEFAULT -version       

docker push ${IMAGE_NAME_DEFAULT}
```

## ZSTD Compression (139MB)

```bash
export BASEIMAGE=scratch
#export BASEIMAGE=gcr.io/distroless/nodejs16-debian11
export IMAGE_NAME_ZSTD=ttl.sh/$(uuidgen):1h
export IMAGE_NAME_ZSTD=${IMAGE_NAME_ZSTD:l}
export COMPRESSION_LEVEL=15

docker build --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION --output type=image,name=$IMAGE_NAME_ZSTD,oci-mediatypes=true,compression=zstd,compression-level=$COMPRESSION_LEVEL,force-compression=true,push=true .

docker images

docker buildx imagetools inspect --raw $IMAGE_NAME_ZSTD

docker run --rm -it $IMAGE_NAME_ZSTD -version       

dive $IMAGE_NAME_ZSTD

mkdir -p ./images
docker image save -o ./images/zstd.tar $IMAGE_NAME_ZSTD
mkdir -p ./images/zstd && tar -xvf ./images/zstd.tar -C $_

# you can see the layers compression types
file ./images/zstd/blobs/sha256/07b322a02bbb25038aa57f662e45f9f01d30f06b299f156749ca3a1f515f60af 
./images/zstd/blobs/sha256/07b322a02bbb25038aa57f662e45f9f01d30f06b299f156749ca3a1f515f60af: Zstandard compressed data (v0.8+), Dictionary ID: None
```

## ESTARGZ Compression (163 MB)

```bash
export BASEIMAGE=scratch
#export BASEIMAGE=gcr.io/distroless/nodejs16-debian11
export IMAGE_NAME_ESTARGZ=ttl.sh/$(uuidgen):1h
export IMAGE_NAME_ESTARGZ=${IMAGE_NAME_ESTARGZ:l}

docker build --build-arg=baseimage=$BASEIMAGE --build-arg=NIX_FILE=ffmpeg-full.nix --build-arg=PROGRAM_FILE=ffmpeg --progress=plain -f Dockerfile.ffmpeg --target PRODUCTION --output type=image,name=$IMAGE_NAME_ESTARGZ,oci-mediatypes=true,compression=estargz,force-compression=true,push=true .

docker images

docker buildx imagetools inspect --raw $IMAGE_NAME_ESTARGZ

docker run --rm -it $IMAGE_NAME_ESTARGZ -version       

dive $IMAGE_NAME_ESTARGZ

mkdir -p ./images
docker image save -o ./images/estargz.tar $IMAGE_NAME_ESTARGZ
mkdir -p ./images/estargz && tar -xvf ./images/estargz.tar -C $_

# you can see the layers compression types
file ./images/estargz/blobs/sha256/5407bcff34cef38fcee5d15db2ac8145a2d6b76a580a9ed96c18c2bdab28a1a3 
./images/estargz/blobs/sha256/5407bcff34cef38fcee5d15db2ac8145a2d6b76a580a9ed96c18c2bdab28a1a3: gzip compressed data, original size modulo 2^32 0
```


## Resources

* Startup Containers in Lightning Speed with Lazy Image Distribution on Containerd [here](https://medium.com/nttlabs/startup-containers-in-lightning-speed-with-lazy-image-distribution-on-containerd-243d94522361)
* Speeding Up Pulling Container Images on a Variety of Tools with eStargz [here](https://medium.com/nttlabs/lazy-pulling-estargz-ef35812d73de)
* containerd/stargz-snapshotter repo [here](https://github.com/containerd/stargz-snapshotter)
* CRFS: Container Registry Filesystem [here](https://github.com/google/crfs)
* awslabs/soci-snapshotter repo [here](https://github.com/awslabs/soci-snapshotter)  
* Reducing AWS Fargate Startup Times with zstd Compressed Container Images [here](https://aws.amazon.com/blogs/containers/reducing-aws-fargate-startup-times-with-zstd-compressed-container-images/)
* Image Manifest V 2, Schema 2 [here](https://docs.docker.com/registry/spec/manifest-v2-2/)
* Lazy pulling stargz/eStargz base images [here](https://github.com/moby/buildkit/blob/master/docs/stargz-estargz.md)
* Where is buildkitd.toml when running on WSL2? #2906 [here](https://github.com/moby/buildkit/issues/2906)
* Smaller and faster data compression with Zstandard [here](https://engineering.fb.com/2016/08/31/core-data/smaller-and-faster-data-compression-with-zstandard/)  
