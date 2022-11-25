# README

Demonstrates copying data out of container images.

## Reason

We always see cases where we want to get files from containers.  If the image is executing then we can use `docker cp`, but if it's build time we can use --output.  

## Example - Running Containers

Go through a few examples of how to extract binaries from built containers.  

ℹ️ NOTE: You do not have to name the container as the id will also work.  

Create a container and copy bash out of it  

```sh
# create a container
docker create --name bash bash:5.0.7

# copy file from container
docker cp bash:/usr/local/bin/bash .

# clean up
docker rm bash
```

Execute a container and copy bash out if it.  

```sh
# create a running container
docker run -it -d --rm --name bash --entrypoint /usr/local/bin/bash bash:5.0.7

# copy file from container
docker cp bash:/usr/local/bin/bash .

# clean up
docker stop bash
```

## Example - Build Time

We now also have the ability to output files during build.  

```sh
# build image with output
docker build -f Dockerfile -t buildoutput --output ./out .

# show file from inside container.
cat ./out/usr/share/nginx/html/index.html 
```

## Resources

- Custom build outputs [here](https://docs.docker.com/engine/reference/commandline/build/#custom-build-outputs)  
