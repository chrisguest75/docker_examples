# WINDOWS CONTAINER

Demonstrate how to build Windows Containers.  

TODO:

* Does docker exec work?
* Looking at the contents
* CSC? missing

## Prereqs 

You'll need docker desktop switched into Windows Container mode.  

```sh
# install hyperv and containers feature
Enable-WindowsOptionalFeature -Online -FeatureName $(“Microsoft-Hyper-V”, “Containers”) -All

```

## Build

```sh
docker context ls

#Switch to windows containers using menu or dockercli
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchLinuxEngine
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchWindowsEngine
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchDaemon

# show the builders and sockets
docker context ls
```

## Build IIS 

```sh
# in windows cmd prompt (build iis)
docker --context desktop-windows build -f Dockerfile.iis -t iisexample:latest .

docker run --rm -it -p 8000:80 --name iisexample iisexample:latest 


```

## .Net App

```sh
docker --context desktop-windows build -t myapp:latest .


docker run -it --entrypoint /bin/sh myapp:latest 

```

## Resources

* Tutorial: Containerize a .NET app [here](https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows)
* Docker command line to switch to running linux containers on Windows Core machine [here](https://stackoverflow.com/questions/57081352/docker-command-line-to-switch-to-running-linux-containers-on-windows-core-machin) 
* Error response from daemon: open \\.\pipe\docker_engine_windows: The system cannot find the file specified [here](https://forums.docker.com/t/error-response-from-daemon-open-pipe-docker-engine-windows-the-system-cannot-find-the-file-specified/131750/2)


https://learn.microsoft.com/en-us/dotnet/architecture/modernize-with-azure-containers/modernize-existing-apps-to-cloud-optimized/deploy-existing-net-apps-as-windows-containers

https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/manage-windows-dockerfile

https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/windows-container-samples