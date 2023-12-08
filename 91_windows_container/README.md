# WINDOWS CONTAINER

Demonstrate how to build Windows Containers.  

TODO:

* IIS not working
* servercore version
* multistage

## Prereqs

You'll need docker desktop switched into Windows Container mode.  

```sh
# install hyperv and containers feature
Enable-WindowsOptionalFeature -Online -FeatureName $(“Microsoft-Hyper-V”, “Containers”) -All
```

## Build

Open a windows cmd prompt.  

```sh
docker context ls

# Switch to windows containers using menu or dockercli
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchLinuxEngine

# enable windows docker engine
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchWindowsEngine

# toggle
"c:\Program Files\Docker\Docker\DockerCli.exe" -SwitchDaemon

# show the builders and sockets (you can see the context switching so either windows or linux is default)
docker context ls
```

## .Net App

```sh
# build
docker --context desktop-windows build -f Dockerfile.net6 -t myapp:latest .

# start it in a cmd prompt
docker run -v "C:\mycode\docker_examples\91_windows_container:C:\app" --rm -it --entrypoint "C:\Windows\System32\cmd.exe" --name myapp myapp:latest

dotnet --list-sdks
dotnet new console --framework net6.0 --use-program-main
dotnet build
C:\app\bin\Debug\net6.0\app.exe

# run built 
docker run --rm -it --entrypoint "C:\Windows\System32\cmd.exe" --name myapp myapp:latest
```

## Build IIS (NOT WORKING)

```sh
# in windows cmd prompt (build iis)
docker --context desktop-windows build -f Dockerfile.iis -t iisexample:latest .

docker images

# stop into
docker run --rm -it -p 8000:80 --name iisexample iisexample:latest 

# run detached
docker run --rm -d -p 8000:80 --name iisexample iisexample:latest 

docker logs iisexample
```

## Resources

* Tutorial: Containerize a .NET app [here](https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows)
* Docker command line to switch to running linux containers on Windows Core machine [here](https://stackoverflow.com/questions/57081352/docker-command-line-to-switch-to-running-linux-containers-on-windows-core-machin)  
* Error response from daemon: open \\.\pipe\docker_engine_windows: The system cannot find the file specified [here](https://forums.docker.com/t/error-response-from-daemon-open-pipe-docker-engine-windows-the-system-cannot-find-the-file-specified/131750/2)
* Deploy existing .NET apps as Windows containers [here](https://learn.microsoft.com/en-us/dotnet/architecture/modernize-with-azure-containers/modernize-existing-apps-to-cloud-optimized/deploy-existing-net-apps-as-windows-containers)
* Dockerfile on Windows [here](https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/manage-windows-dockerfile)  
* windows-container-samples repo [here](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/windows-container-samples)  
* Building a Multi-Container .NET App Using Docker Desktop [here](https://www.docker.com/blog/building-multi-container-net-app-using-docker-desktop/)  
* 9 Tips for Containerizing Your .NET Application [here](https://www.docker.com/blog/9-tips-for-containerizing-your-net-application/)  
* 'csc' is not recognized as an internal or external command, operable program or batch file [here](https://stackoverflow.com/questions/43080312/csc-is-not-recognized-as-an-internal-or-external-command-operable-program-or)
