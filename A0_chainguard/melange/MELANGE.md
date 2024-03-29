# MELANGE

Build apk packages using declarative pipelines.  

## Build custom image

```sh
# pull required images
docker pull cgr.dev/chainguard/melange
docker pull cgr.dev/chainguard/apko

# generate a key
mkdir -p ./out
docker run --rm -v ./out:/work cgr.dev/chainguard/melange keygen

# build packages
docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/curl.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/nodejs-20.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/ffmpeg.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

# build image
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/image.yaml chainguard-ffmpeg-node:latest /work/out/chainguard-ffmpeg-node.tar -k /work/out/melange.rsa.pub

# load image
docker load < ./out/chainguard-ffmpeg-node.tar

# run built image
docker run --rm chainguard-ffmpeg-node:latest-amd64 node --version
docker run --rm chainguard-ffmpeg-node:latest-amd64 ffmpeg -version
```

## Hello Wolfi Workshop Kit

REF: [chainguard-dev/hello-wolfi-demo](https://github.com/chainguard-dev/hello-wolfi-demo)  
NOTE: The repo is archived.  

```sh
# clone repo
git clone https://github.com/chainguard-dev/hello-wolfi-demo.git

# pull required images
docker pull cgr.dev/chainguard/melange
docker pull cgr.dev/chainguard/apko

# generate a key
docker run --rm -v "${PWD}":/work cgr.dev/chainguard/melange keygen

# build packages
docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-php.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub

docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-composer.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub

docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-app.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub

# build image
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/apko.yaml hello-wolfi:latest /work/hello-wolfi.tar -k /work/melange.rsa.pub

# load image
docker load < hello-wolfi.tar

# run built image
docker run --rm hello-wolfi:latest-amd64
```








## Resources

* Community workshop kit about Wolfi for beginners [here](https://edu.chainguard.dev/open-source/wolfi/hello-wolfi/)  
* chainguard-dev/melange repo [here](https://github.com/chainguard-dev/melange)