# README
Demonstrates adding label metadata to builds that helps us trace pipelines and build sources.

[Container Specifcation](https://github.com/opencontainers/image-spec/blob/master/annotations.md)

## Labels
Build an image and add labels to it. 
```sh
CREATED=$(date "+%Y-%m-%dT%H:%M:%SZ")
VERSION=$(git log --pretty=tformat:"%H" -n 1)
URL=$(git remote get-url origin)
docker build --label "org.opencontainers.image.created=${CREATED}" --label "org.opencontainers.image.version=${VERSION}" --label "org.opencontainers.image.url=${URL}" --no-cache -t labels -f Dockerfile .
```

Inspect the labels added to the image
```sh
docker inspect -f {{.Config.Labels}} labels
```

## Simplified version 
Use this version when copying into build scripts
```sh
docker build --label "org.opencontainers.image.created=$(date '+%Y-%m-%dT%H:%M:%SZ')" --label "org.opencontainers.image.version=$(git log --pretty=tformat:'%H' -n 1)" --label "org.opencontainers.image.url=$(git remote get-url origin)" --no-cache -t labels -f Dockerfile .
```