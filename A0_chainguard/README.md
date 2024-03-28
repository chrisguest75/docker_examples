# CHAINGUARD

Your safe source for open source - Build it right. Build it safe. Build it fast.

NOTES:

* wolfi - Distroless containers
* apko - Building images from packages
* melange - Creating packages for use in aplko

## Contents

- [CHAINGUARD](#chainguard)
  - [Contents](#contents)
  - [Simple Pull](#simple-pull)
  - [Cosign](#cosign)
  - [APKO](#apko)
    - [Wolfi Base](#wolfi-base)
    - [FFMPEG](#ffmpeg)
    - [FFMPEG with Node](#ffmpeg-with-node)
  - [NodeJS](#nodejs)
  - [Resources](#resources)
    - [APKO Links](#apko-links)
    - [Cosign Links](#cosign-links)

TODO:

* node - https://edu.chainguard.dev/chainguard/chainguard-images/reference/node/

## Simple Pull

```sh
# get ffmpeg
docker pull cgr.dev/chainguard/ffmpeg    

# look inside
dive cgr.dev/chainguard/ffmpeg    

# run
docker run -it --entrypoint /usr/bin/ffmpeg cgr.dev/chainguard/ffmpeg 
```

## Cosign

Verify image

```sh
brew install cosign

IMAGE=go
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/main \
  cgr.dev/chainguard/${IMAGE} | jq
```

## APKO

```sh
# apko version
docker run --rm cgr.dev/chainguard/apko version
```

### Wolfi Base

```sh
# create a base image
docker run --rm -v ${PWD}/apko/wolfi-base:/apko -v ${PWD}/apko/work:/work -w /work cgr.dev/chainguard/apko build /apko/wolfi-base.yaml wolfi-base:test wolfi-test.tar

# load and test
docker load < ./apko/work/wolfi-test.tar
docker run -it wolfi-base:test-amd64
```

### FFMPEG

Create an image with ffmpeg  

```sh
# create ffmpeg image
docker run --rm -v ${PWD}/apko/ffmpeg:/apko -v ${PWD}/apko/work:/work -w /work cgr.dev/chainguard/apko build /apko/wolfi-ffmpeg.yaml wolfi-ffmpeg:test wolfi-ffmpeg.tar

# load and test
docker load < ./apko/work/wolfi-ffmpeg.tar
docker run -it wolfi-ffmpeg:test-amd64
```

### FFMPEG with Node

Create an image with both ffmpeg and node  

```sh
# create ffmpeg image
docker run --rm -v ${PWD}/apko/ffmpeg_nodejs:/apko -v ${PWD}/apko/work:/work -w /work cgr.dev/chainguard/apko build /apko/wolfi-ffmpeg-nodejs.yaml wolfi-ffmpeg-nodejs:test wolfi-ffmpeg-nodejs.tar

# load and test
docker load < ./apko/work/wolfi-ffmpeg-nodejs.tar
docker run -it wolfi-ffmpeg-nodejs:test-amd64

# scanning
grype -o json wolfi-ffmpeg-nodejs:test-amd64 
# comparee to
grype -o json node:latest   

# docker scout quickview wolfi-ffmpeg-nodejs:test-amd64 
```

## NodeJS

Get the prebuilt node images  

```sh
docker pull cgr.dev/chainguard/node-lts:latest

# node --version
docker run -it cgr.dev/chainguard/node-lts:latest --version
```

## Resources

* Chainguard [here](https://www.chainguard.dev/)
* Chainguard Academy [here](https://edu.chainguard.dev/)

* In Pursuit of Better Container Images: Alpine, Distroless, Apko, Chisel, DockerSlim, oh my! [here](https://iximiuz.com/en/posts/containers-making-images-better/)
* Is Your Container Image Really Distroless? [here](https://www.docker.com/blog/is-your-container-image-really-distroless/)

### APKO Links

* Getting Started with apko [here](https://edu.chainguard.dev/open-source/apko/getting-started-with-apko/)
* https://github.com/wolfi-dev/os
* https://github.com/chainguard-dev/apko/

### Cosign Links

* https://edu.chainguard.dev/open-source/sigstore/cosign/how-to-install-cosign/
