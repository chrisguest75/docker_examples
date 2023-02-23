# WINDOWS CONTAINER

Demonstrate 

```sh
Enable-WindowsOptionalFeature -Online -FeatureName $(“Microsoft-Hyper-V”, “Containers”) -All
```

```sh
docker context ls

Switch to windows containers using menu

docker context ls

docker --context desktop-windows build -t myapp:latest .
```

## Resources


https://forums.docker.com/t/error-response-from-daemon-open-pipe-docker-engine-windows-the-system-cannot-find-the-file-specified/131750/2