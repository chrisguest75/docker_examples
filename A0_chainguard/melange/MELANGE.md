# MELANGE

Build apk packages using declarative pipelines.  

## Contents

- [MELANGE](#melange)
  - [Contents](#contents)
  - [Clone package definitions](#clone-package-definitions)
  - [Build custom image](#build-custom-image)
  - [Hello Wolfi Workshop Kit](#hello-wolfi-workshop-kit)
  - [Resources](#resources)

## Clone package definitions

```sh
git clone git@github.com:wolfi-dev/os.git wolfios

docker pull ghcr.io/wolfi-dev/sdk:latest
```

## Build custom image

This builds a custom distroless image with node20 and ffmpeg.  

```sh
# pull required images
docker pull cgr.dev/chainguard/melange
docker pull cgr.dev/chainguard/apko

# generate a key
cd ./A0_chainguard/melange
mkdir -p ./out
docker run --rm -v ./out:/work cgr.dev/chainguard/melange keygen

# build packages (curl)
docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/curl.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

# build packages (node18)
docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/nodejs-18.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

# build packages (node20)
docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/nodejs-20.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

# build packages (ffmpeg)
docker run --privileged --rm -v $(pwd):/work -- \
  cgr.dev/chainguard/melange build /work/ffmpeg.yaml --out-dir /work/out \
  --arch x86_64 --signing-key /work/out/melange.rsa --keyring-append /work/out/melange.rsa.pub

# build image (ffmpeg)
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/image-ffmpeg.yaml chainguard-ffmpeg:latest /work/out/chainguard-ffmpeg.tar -k /work/out/melange.rsa.pub 
# build image (node18)
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/image-node18.yaml chainguard-node18:latest /work/out/chainguard-node18.tar -k /work/out/melange.rsa.pub
# build image (node18 - ffmpeg)
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/image-node18-ffmpeg.yaml chainguard-node18-ffmpeg:latest /work/out/chainguard-node18-ffmpeg.tar -k /work/out/melange.rsa.pub
# build image (node20)
docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/image-node20-ffmpeg.yaml chainguard-node20-ffmpeg:latest /work/out/chainguard-node20-ffmpeg.tar -k /work/out/melange.rsa.pub

# load image
docker load < ./out/chainguard-ffmpeg.tar
docker load < ./out/chainguard-node18.tar
docker load < ./out/chainguard-node18-ffmpeg.tar
docker load < ./out/chainguard-node20-ffmpeg.tar

# run built image (node18)
docker run --rm chainguard-ffmpeg:latest-amd64 -version

docker run --rm chainguard-node18:latest-amd64 --version

docker run --rm chainguard-node18-ffmpeg:latest-amd64 --version
docker run --rm --entrypoint /usr/bin/ffmpeg chainguard-node18-ffmpeg:latest-amd64 -version
docker run --rm --entrypoint /usr/bin/ffmpeg chainguard-node18-ffmpeg:latest-amd64 -codecs

# run built image (node20)
docker run --rm chainguard-node20-ffmpeg:latest-amd64 --version
docker run --rm --entrypoint /usr/bin/ffmpeg chainguard-node20-ffmpeg:latest-amd64 -version
docker run --rm --entrypoint /usr/bin/ffmpeg chainguard-node20-ffmpeg:latest-amd64 -codecs

# analyse
dive chainguard-node18-ffmpeg:latest-amd64

# scan image
grype -o json chainguard-node18-ffmpeg:latest-amd64
```

## Hello Wolfi Workshop Kit

This is what I used to work out how to build the packages.  

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
* Creating Wolfi Images with Dockerfiles [here](https://edu.chainguard.dev/open-source/wolfi/wolfi-with-dockerfiles/)  
* wolfi-dev/os repo [here](https://github.com/wolfi-dev/os)
