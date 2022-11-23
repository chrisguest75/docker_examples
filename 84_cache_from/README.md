# CACHING

Demonstrate how to use `--cache-from` to speed up builds.  

## Reason

Using intermediate builds as caches for work already performed.  
The idea is that you use previous builds in the pipeline to cache from.  The idea being that these are the closest to your build.  

TODO:

- Push images to registry
- merge-base

NOTES:

- buildkit can pull cached images during build
- It is possible to use multiple images as cache sources  

## Build

```sh
export CURRENT_TAG=$(git rev-parse HEAD)
# build first stage builder
docker build -f Dockerfile.jq --target BUILDER -t cachefrom:BUILDER_$CURRENT_TAG .

# would push here

# build production
docker build -f Dockerfile.jq --target PRODUCTION -t cachefrom:PRODUCTION_$CURRENT_TAG .

# test image
docker run --rm -t cachefrom:PRODUCTION_$CURRENT_TAG
docker run --rm -t cachefrom:PRODUCTION_$CURRENT_TAG . /data/1.json
```

## Next commit

```sh
git checkout -b newbranch 

cp ./data/1.json ./data/5.json 

git add ./data/5.json 
git commit -m "test"
```

## Cached build

```sh
export NEW_TAG=$(git rev-parse HEAD^)
# build first stage builder
docker build -f Dockerfile.jq --cache-from cachefrom:BUILDER_$CURRENT_TAG --target BUILDER -t cachefrom:BUILDER_$NEW_TAG .

# would push here

# build production
docker build -f Dockerfile.jq --cache-from cachefrom:PRODUCTION_$CURRENT_TAG --target PRODUCTION -t cachefrom:PRODUCTION_$NEW_TAG .

# test image
docker run --rm -t cachefrom:PRODUCTION_$NEW_TAG
docker run --rm -t cachefrom:PRODUCTION_$NEW_TAG . /data/1.json
```

## Resources

- Speed up your Docker builds with –cache-from [here](https://lipanski.com/posts/speed-up-your-docker-builds-with-cache-from)  
- Faster CI Builds with Docker Layer Caching and BuildKit [here](https://testdriven.io/blog/faster-ci-builds-with-docker-cache/)  
