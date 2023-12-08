# README

Demonstrates adding label metadata to builds that helps us trace pipelines and build sources.

[Container Specifcation](https://github.com/opencontainers/image-spec/blob/master/annotations.md)

## Labels

Build an image and add labels to it.  

```sh
CREATED=$(date "+%Y-%m-%dT%H:%M:%SZ")
VERSION=$(git log --pretty=tformat:"%H" -n 1)
URL=$(git remote get-url origin)
BY=$(whoami)
# this is a org custom label
ON=$(hostname)
cat <<- EOF > ./details.txt
CREATED=$CREATED
VERSION=$VERSION
URL=$URL
BY=$BY
ON=$ON
EOF
docker build --progress=plain --label "org.opencontainers.image.created=${CREATED}" --label "org.opencontainers.image.version=${VERSION}" --label "org.opencontainers.image.url=${URL}" --label "org.opencontainers.image.authors=${BY}" --label "org.chrisguest75.builton=${ON}" --no-cache -t labels -f Dockerfile .
```

Inspect the labels added to the image  

```sh
# show labels on labels image
# NOTE: There are also labels generated in the Dockerfile.  '--label' overrides internal 'org.opencontainers.image.authors=me'
docker inspect -f "{{ .Config.Labels }}" labels 
```

Now pass in a `--build-arg` as well.  
NOTE: This is does not seem to work. The build-arg for the `baseimage` does not seem to be usable beyond the `FROM` tag  

```sh
# Apply a build-arg baseimage.  
BASEIMAGE="ubuntu:21.04"
docker build --progress=plain --build-arg baseimage="$BASEIMAGE" --build-arg message="a build message" --label "chrisguest75/baseimage=${BASEIMAGE}" --label "org.opencontainers.image.created=${CREATED}" --label "org.opencontainers.image.version=${VERSION}" --label "org.opencontainers.image.url=${URL}" --label "org.opencontainers.image.authors=${BY}" --label "org.chrisguest75.builton=${ON}" --no-cache -t labels -f Dockerfile .

# show labels
docker inspect -f "{{ .Config.Labels }}" labels 
docker inspect --format '{{ index .Config.Labels "chrisguest75/baseimage"}}' labels
docker inspect --format '{{ index .Config.Labels "dockerfile.baseimage"}}' labels
docker inspect --format '{{ index .Config.Labels "org.opencontainers.image.created"}}' labels
```

Filter out images with a label  

```sh
# filter by having label
docker images --digests --filter "label=org.opencontainers.image.url" --format "{{ .Repository }}:{{ .Tag }} {{ .Digest }}"

# get digest (will be <none> as built locally) 
docker image ls --digests --format "{{ .Digest }}" labels:latest
```

## Simplified version

Use this version when copying into build scripts  

```sh
docker build --label "org.opencontainers.image.created=$(date '+%Y-%m-%dT%H:%M:%SZ')" --label "org.opencontainers.image.version=$(git log --pretty=tformat:'%H' -n 1)" --label "org.opencontainers.image.url=$(git remote get-url origin)" --no-cache -t labels -f Dockerfile .
```

## Adding a label to existing image (on test image)

```sh
# locally built has no digest
DIGEST=$(docker image ls --digests --format "{{ .Digest }}" labels:latest)
# adding a label with quick trick to rebase image.
echo "FROM labels" | docker build --label "org.chrisguest75.originaldigest=${DIGEST}" -t "newlabels" -

# inspect the labels for each image
docker inspect -f {{.Config.Labels}} labels
docker inspect -f {{.Config.Labels}} newlabels

# differences between the images. 
docker inspect labels > inspect_labels.txt
docker inspect newlabels > inspect_newlabels.txt
```

## Adding a label to an existing public image (on nginx)

```sh
docker pull nginx:1.20.1
DIGEST=$(docker image ls --digests --format "{{ .Digest }}" nginx:1.20.1)
echo ${DIGEST}
# adding a label with quick trick to rebase image.
echo "FROM nginx:1.20.1" | docker build --label "org.chrisguest75.originaldigest=${DIGEST}" -t "newnginx:1.20.1" -  

# inspect the labels for each image
docker inspect -f {{.Config.Labels}} nginx:1.20.1
docker inspect -f {{.Config.Labels}} newnginx:1.20.1

# differences between the images. 
docker inspect nginx:1.20.1 > inspect_nginx.txt
docker inspect newnginx > inspect_newnginx.txt
```

## Runtime labels

```sh
# run a container with labels 
docker run --label-file ./labels.labels --rm -d -p 8080:80 --name nginx nginx:1.20.1
docker inspect $(docker ps --filter name=nginx -q)
docker stop $(docker ps --filter name=nginx -q)
```

## NOTES

When running `docker inspect` the output in ContainerConfig will be different.  

*ContainerConfig* This data again is referring to the temporary container created when the Docker build command was executed.
[REF](https://www.ctl.io/developers/blog/post/what-to-inspect-when-youre-inspecting)  

## 👀 Resources

* docker-registry-v2 slides [here](https://www.slideshare.net/Docker/docker-registry-v2)  
* docker image docs [here](https://docs.docker.com/engine/reference/commandline/images/)  
* labels-custom-metadata [here](https://docs.docker.com/config/labels-custom-metadata/)  
* Quay tag expiration [here](https://access.redhat.com/documentation/en-us/red_hat_quay/3/html/use_red_hat_quay/working_with_tags#tag-expiration)  
* what-to-inspect-when-youre-inspecting [here](https://www.ctl.io/developers/blog/post/what-to-inspect-when-youre-inspecting)  
