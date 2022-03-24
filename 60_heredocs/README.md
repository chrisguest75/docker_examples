# README

Demonstrate how to use HEREDOC in a Dockerfile.

## Build

```sh
# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -t heredoc .

# run
docker run -it --name heredoc --rm heredoc  

# debug
docker run -it --rm --name heredoc --entrypoint "/bin/bash" heredoc
```

## Resources

* Introduction to heredocs in Dockerfiles [here](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/)