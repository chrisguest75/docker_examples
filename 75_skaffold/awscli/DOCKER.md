# README

Create a container containing AWS CLI and build credentials into it.  

NOTE: We build the credentials into it so we can use with Skaffold docker support.  

## Build

```sh
# set profile
export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1

# build the image (with hardcoded profile for skaffold)
docker buildx build --no-cache --progress=plain --build-arg AWS_PROFILE=$AWS_PROFILE --build-arg AWS_REGION=$AWS_REGION --build-context profile=/Users/${USER}/.aws -t awscli . 
```

## Run

```sh
# use cli with built in profile (should not be pushed)
docker run --rm -it awscli s3 ls

# run a command 
docker run --rm -it -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION awscli s3 ls
```

### Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```
