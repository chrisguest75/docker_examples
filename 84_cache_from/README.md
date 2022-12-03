# CACHING

Demonstrate how to use `--cache-from` to speed up builds.  

## Reason

Using intermediate builds as caches for work already performed.  
The idea is that you use previous builds in the pipeline to cache from.  The idea being that these are the closest to your build.  

TODO:

- Find branch-base/merge-base commit for caching branches

NOTES:

- buildkit can pull cached images during build
- It is possible to use multiple images as cache sources  

## Build

```sh
# use AWS for intermediate caching builds
export PAGER=
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-1

# create an ECR registry
export REPOSITORY_URL=$(aws --profile $AWS_PROFILE --region $AWS_REGION ecr create-repository --repository-name cachefromtest  | jq -r .repository.repositoryUri)
export REPOSITORY_URL=$(aws --profile $AWS_PROFILE --region $AWS_REGION ecr describe-repositories --repository-name cachefromtest | jq -r '.repositories[0].repositoryUri')
echo $REPOSITORY_URL

aws --profile $AWS_PROFILE ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "$REPOSITORY_URL"

# OPTIONALLY keep it local without a remote registry
REPOSITORY_URL=cachefrom

# tip of tree current branch
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


docker push "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
```

## Next commit

```sh
git checkout -b newbranch 

cat <<- EOF > "./data/1.json"
{
    "file": "4.json",
    "version": 2
}
EOF
cat ./data/1.json

git add ./data/1.json 
git commit -m "test"
```

## Remove images

```sh
# remove images that could be used in local cache
docker rmi "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"
docker rmi "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
```

## Cached build

```sh
export NEW_TAG=$(git rev-parse HEAD)
export PREVIOUS_TAG=$(git rev-parse HEAD^1)
echo "NEW_TAG=$NEW_TAG"
echo "PREVIOUS_TAG=$PREVIOUS_TAG"
# build first stage builder
docker buildx build -f Dockerfile.jq --cache-from "${REPOSITORY_URL}:BUILDER_${PREVIOUS_TAG}" --target BUILDER -t "${REPOSITORY_URL}:BUILDER_${NEW_TAG}" .

# would push here
docker push "${REPOSITORY_URL}:BUILDER_${NEW_TAG}"

# build production
docker buildx build -f Dockerfile.jq --cache-from "${REPOSITORY_URL}:BUILDER_${NEW_TAG}" --cache-from "${REPOSITORY_URL}:PRODUCTION_${PREVIOUS_TAG}" --target PRODUCTION -t "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}" .

# test image
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}"
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}" . /data/1.json

docker push "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}"
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
