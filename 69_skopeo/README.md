# README

Demonstrate using `Skopeo` to interrogate registries.  

## 📋 Prereqs

```sh
# install it
brew install skopeo
```

## Inspect

```sh
skopeo inspect docker://chrisguest/ubuntu_amd64:latest 
skopeo inspect docker://chrisguest/turn:latest | jq .   

# a particular image details
skopeo inspect --config docker://chrisguest/turn:dfc30c69ff350694677f1372c4845b6a6cfd7e6d
```

## ECR

```sh
skopeo inspect --config --creds=AWS:$(aws --profile $AWS_PROFILE ecr get-login-password --region $AWS_REGION) docker://xxxxxxxx.dkr.ecr.${AWS_REGION}.amazonaws.com/myecrimage:latest | jq .
```

## List Tags

```sh
# list the tags for an image. 
skopeo list-tags docker://chrisguest/turn | jq .
```

## Copy images

```sh
# NOTE: Ensure robot has write permissions
export DESTUSER=<robot account>
export DESTPASS=<robot password>

skopeo copy --dest-creds=$DESTUSER:$DESTPASS docker://chrisguest/turn:latest docker://quay.io/guestchris75/turn:latest
```

## Delete images

```sh
# NOTE: The robot account needs admin permissions 
skopeo delete --creds=$DESTUSER:$DESTPASS docker://quay.io/guestchris75/turn:latest
```

## 👀 Resources

* containers/skopeo repo [here](https://github.com/containers/skopeo)  
