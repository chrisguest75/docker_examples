# README

Demonstrate how to use HEREDOC in a Dockerfile.  

ℹ️ NOTE: Top of dockerfile to tell docker which syntax to use `# syntax=docker/dockerfile:1.4`  

## 🏠 Build

Build the image containing the `heredoc`.  

```sh
# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -t heredoc .
```

Run with the parameterised `heredoc` created script.   

```sh
# run ping (default google)
docker run -it --rm --name heredoc --rm heredoc

# run ping duckduckgo
docker run -it --rm --name heredoc --rm heredoc https://duckduckgo.com
```

Step into the container  

```sh
# debug 
docker run -it --rm --name heredoc --entrypoint "/bin/bash" heredoc

# show heredoc created script
cat /bin/ping.sh
```

## 👀 Resources

* Introduction to heredocs in Dockerfiles [here](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/)
* dockerfile/1.4.0 [here](https://github.com/moby/buildkit/releases/tag/dockerfile%2F1.4.0)