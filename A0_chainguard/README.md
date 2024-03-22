# CHAINGUARD

Your safe source for open source - Build it right. Build it safe. Build it fast.

NOTES:

* wolfi - Distroless containers
* apko - Building images from packages
* melange - Creating packages for use in aplko

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

```sh
# create a base image
docker run --rm -v ${PWD}/apko/wolfi-base:/apko -v ${PWD}/apko/work:/work -w /work cgr.dev/chainguard/apko build /apko/wolfi-base.yaml wolfi-base:test wolfi-test.tar

# load and test
docker load < ./apko/work/wolfi-test.tar
docker run -it wolfi-base:test-amd64

# create ffmpeg image
docker run --rm -v ${PWD}/apko/ffmpeg:/apko -v ${PWD}/apko/work:/work -w /work cgr.dev/chainguard/apko build /apko/wolfi-ffmpeg.yaml wolfi-ffmpeg:test wolfi-ffmpeg.tar

# load and test
docker load < ./apko/work/wolfi-ffmpeg.tar
docker run -it wolfi-ffmpeg:test-amd64
```

## NodeJS

```sh
docker pull cgr.dev/chainguard/node-lts:latest

# node --version
docker run -it cgr.dev/chainguard/node-lts:latest --version
```

## Resources

* Chainguard [here](https://www.chainguard.dev/)
* Chainguard Academy [here](https://edu.chainguard.dev/)

* https://iximiuz.com/en/posts/containers-making-images-better/

### APKO

* https://edu.chainguard.dev/open-source/apko/getting-started-with-apko/
* https://github.com/wolfi-dev/os
* https://github.com/chainguard-dev/apko/

### Cosign

* https://edu.chainguard.dev/open-source/sigstore/cosign/how-to-install-cosign/



