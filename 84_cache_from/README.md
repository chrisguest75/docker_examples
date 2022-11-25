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
AWS_PROFILE=myprofile

REPOSITORY_URL=$(aws --profile $AWS_PROFILE ecr create-repository --repository-name cachefromtest --region eu-west-1 | jq -r .repository.repositoryUri)
echo $REPOSITORY_URL

aws --profile $AWS_PROFILE ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "$REPOSITORY_URL"


# OPTIONAL to keep it local
REPOSITORY_URL=cachefrom

export CURRENT_TAG=$(git rev-parse HEAD)


# THIS DOESN'T WORK
docker buildx build -f Dockerfile.jq --cache: "enabled" --build-arg BUILDKIT_INLINE_CACHE=1 --push -t $REPOSITORY_URL:$CURRENT_TAG \
  --cache-to type=registry,ref=$REPOSITORY_URL:$CURRENT_TAG \
  --cache-from type=registry,ref=$REPOSITORY_URL:$CURRENT_TAG .

# build first stage builder
docker buildx build -f Dockerfile.jq --target BUILDER -t "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}" .

# would push here
docker push "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"

# build production
docker buildx build -f Dockerfile.jq --target PRODUCTION -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" .

# test image
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" . /data/1.json
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
docker build -f Dockerfile.jq --cache-from "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}" --target BUILDER -t "${REPOSITORY_URL}:BUILDER_${NEW_TAG}" .

# would push here

# build production
docker build -f Dockerfile.jq --cache-from cachefrom:PRODUCTION_$CURRENT_TAG --target PRODUCTION -t "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}" .

# test image
docker run --rm -t cachefrom:PRODUCTION_$NEW_TAG
docker run --rm -t cachefrom:PRODUCTION_$NEW_TAG . /data/1.json
```

## Cleanup

```sh
aws --profile $AWS_PROFILE ecr delete-repository --repository-name cachefromtest --region eu-west-1 --force
```

## Resources

- Speed up your Docker builds with –cache-from [here](https://lipanski.com/posts/speed-up-your-docker-builds-with-cache-from)  
- Faster CI Builds with Docker Layer Caching and BuildKit [here](https://testdriven.io/blog/faster-ci-builds-with-docker-cache/)  
- Cache storage backends [here](https://docs.docker.com/build/building/cache/backends/)
- How to debug buildkit caching? [here](https://forums.docker.com/t/how-to-debug-buildkit-caching/114578)  
