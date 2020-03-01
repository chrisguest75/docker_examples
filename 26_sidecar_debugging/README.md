# README.md
Demonstrate how to inject a sidecar container with some extra debugging tools 

## Script to follow
Build and execute the container with some code we want to debug.
```sh
docker build -f code.Dockerfile -t code_sidecar . 
docker run -d -it --rm --name code_sidecar code_sidecar  
```

Inject the container with some extra debugging tools
```sh
docker build -f debug.Dockerfile -t debug_sidecar . 
docker run -it --rm --pid=container:$(docker ps --filter name=code_sidecar -q) --name debug_sidecar --entrypoint /bin/bash debug_sidecar  
```

Show all processes in the namespace
```sh
ps -aux
```

## Clean up
```sh
docker stop $(docker ps --filter name=code_sidecar -q)           
```