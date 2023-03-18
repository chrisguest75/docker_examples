# README

Demonstrate how to use HEREDOC in a Dockerfile.  

ℹ️ NOTES:

* Top of dockerfile to tell docker which syntax to use `# syntax=docker/dockerfile:1.4`  
* HEREDOCS can be placed inside Dockerfile HEREDOCS.

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

# run the script to generate the heredoc into a file.  
cat /bin
./heredoc.sh 
cat ./subheredoc.sh 
```

## 👀 Resources

* Introduction to heredocs in Dockerfiles [here](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/)
* dockerfile/1.4.0 [here](https://github.com/moby/buildkit/releases/tag/dockerfile%2F1.4.0)
* Proposal: Add --chmod flag to ADD/COPY commands (analogous to --chown) [here](https://github.com/moby/moby/issues/34819#issuecomment-697130379)  
