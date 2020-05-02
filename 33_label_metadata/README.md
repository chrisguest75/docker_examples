# README
Demonstrates adding label metadata to builds that helps us trace pipelines and build sources.

## Labels
Build an image and add labels to it. 
```sh
BUILD_DATE=$(date "+%Y%m%d-%H%M%S")
PIPELINE_ID=$(git remote get-url origin)
COMMIT_ID=$(git log --pretty=tformat:"%H" -n 1)
docker build --label "BUILD_DATE=${BUILD_DATE}" --label "PIPELINE_ID=${PIPELINE_ID}" --label "COMMIT_ID=${COMMIT_ID}" --no-cache -t labels -f Dockerfile .
```

Inspect the labels added to the image
```sh
docker inspect -f {{.Config.Labels}} labels
```