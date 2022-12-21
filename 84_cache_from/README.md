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

## Setup Repository

To test caching we used `sleep` in a layer to give the impression of a long running build process.  

```sh
# use AWS for intermediate caching builds
export PAGER=
export AWS_REGION=eu-west-1
export AWS_PROFILE=myprofile

# create an ECR registry (skip if already created)
export REPOSITORY_URL=$(aws --profile $AWS_PROFILE --region $AWS_REGION ecr create-repository --repository-name cachefromtest  | jq -r .repository.repositoryUri)
# get full repo-url
export REPOSITORY_URL=$(aws --profile $AWS_PROFILE --region $AWS_REGION ecr describe-repositories --repository-name cachefromtest | jq -r '.repositories[0].repositoryUri')
echo $REPOSITORY_URL
# login
aws --profile $AWS_PROFILE ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "$REPOSITORY_URL"

# OPTIONALLY keep it local without a remote registry
REPOSITORY_URL=cachefrom

# list any images that might already exist
aws ecr describe-images --repository-name cachefromtest --region $AWS_REGION   

# tip of tree current branch
export CURRENT_TAG=$(git rev-parse HEAD)
echo ${CURRENT_TAG}
```

## Build

First image (no caching)  

NOTE: Only inline cache export is provided by docker

```sh
export SLEEPTIME=15

# build first stage builder
docker buildx build --cache-to=type=inline --build-arg SLEEPTIME=${SLEEPTIME} -f Dockerfile.jq --target BUILDER -t "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}" .

# would push here
docker push "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"

# build production
docker buildx build --cache-to=type=inline --build-arg SLEEPTIME=${SLEEPTIME} -f Dockerfile.jq --target PRODUCTION -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" .

# test image
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
docker run --rm -t "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" . /data/1.json

# push to registry
docker push "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"

echo "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"
echo "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
```

## Remove images

```sh
# show the layers but they're not accessible. 
docker inspect  "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}" | jq -r '.[0].RootFS.Layers[]'  
docker inspect  "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" | jq -r '.[0].RootFS.Layers[]'

# kill all the local containers
docker builder prune 
docker system prune --all --force 
docker system prune

# explicitly remove images that could be used in local cache
docker rmi "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"
docker rmi "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"
```

## Cached build

NOTE: The first build using the cache seems to be slow on the last step.  

```sh
export NEW_TAG=$(git rev-parse HEAD)-1
export PREVIOUS_TAG=$(git rev-parse HEAD^1)
echo "CURRENT_TAG=$CURRENT_TAG"
echo "NEW_TAG=$NEW_TAG"
echo "PREVIOUS_TAG=$PREVIOUS_TAG"

# after removing we pull again.
docker pull "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}"
docker pull "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}"

# build first stage builder
# --cache-to=type=inline,mode=all
docker buildx build --progress=plain --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg SLEEPTIME=${SLEEPTIME} -f Dockerfile.jq --cache-from "${REPOSITORY_URL}:BUILDER_${CURRENT_TAG}" --cache-from "${REPOSITORY_URL}:BUILDER_${PREVIOUS_TAG}" --target BUILDER -t "${REPOSITORY_URL}:BUILDER_${NEW_TAG}" .

# would push here
docker push "${REPOSITORY_URL}:BUILDER_${NEW_TAG}"

# build production
docker buildx build --progress=plain --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg SLEEPTIME=${SLEEPTIME} -f Dockerfile.jq --cache-from "${REPOSITORY_URL}:PRODUCTION_${CURRENT_TAG}" --cache-from "${REPOSITORY_URL}:BUILDER_${NEW_TAG}" --cache-from "${REPOSITORY_URL}:PRODUCTION_${PREVIOUS_TAG}" --target PRODUCTION -t "${REPOSITORY_URL}:PRODUCTION_${NEW_TAG}" .

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
- Export build cache to an external cache destination (--cache-to) [here](https://github.com/docker/buildx/blob/master/docs/reference/buildx_build.md#cache-to)
- Use an external cache source for a build (--cache-from) [here](https://github.com/docker/buildx/blob/master/docs/reference/buildx_build.md#cache-from)
- Buildkit: "docker build --cache-from" doesn't use cache from local tagged images (multi-stage builds) #39003 --cache-from not working [here](https://github.com/moby/moby/issues/39003)
- The cache export step hangs #537 [here](https://github.com/docker/buildx/issues/537)  
