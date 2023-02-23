# WINDOWS CONTAINER

Demonstrate how to build Windows Containers.  

TODO:

* Does docker exec work?
* Looking at the contents
* CSC? missing

## Prereqs 

You'll need docker desktop switched into Windows Container mode.  

```sh
Enable-WindowsOptionalFeature -Online -FeatureName $(“Microsoft-Hyper-V”, “Containers”) -All
```

## Build

```sh
docker context ls

#Switch to windows containers using menu

docker context ls

docker --context desktop-windows build -t myapp:latest .
```

## Resources


https://forums.docker.com/t/error-response-from-daemon-open-pipe-docker-engine-windows-the-system-cannot-find-the-file-specified/131750/2

https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows
