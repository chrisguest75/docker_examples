# DOCKER DEBUG BUILD

NOTE: This is not working yet.  

## Install DX Extension

Install `docker.docker` extension.  

## CLI

```sh
docker version
# Buildx is at least version 0.29.x.
docker buildx version

# test if DAP is available
BUILDX_EXPERIMENTAL=1 docker buildx dap

just build-normal

# this doesn't seem to work yet
just build-debug
```

## Inside VSCode

Set a breakpoint in the dockerfile and execute the `Docker: Build` debug configuration.  This will build the image and stop at the breakpoint.  You can then step through the build process and inspect variables.  

```sh
export BUILDX_EXPERIMENTAL=1
code .
```

## Resources

* https://docs.docker.com/reference/cli/docker/buildx/debug/build/
* Debug Docker Builds with Visual Studio Code Blog https://www.docker.com/blog/debug-docker-builds-with-visual-studio-code/
* Extension https://marketplace.visualstudio.com/items?itemName=docker.docker
* Debug Adapter Protocol - https://github.com/docker/buildx/blob/master/docs/dap.md
* DAP https://microsoft.github.io/debug-adapter-protocol/overview
* https://github.com/docker/vscode-extension/blob/HEAD/DEBUGGING.md