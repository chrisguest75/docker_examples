# README

Demonstrate using the cpu limitations on containers.  

Build the container and execute with the constraints  

TODO:

```txt
      --cpu-period int                 Limit CPU CFS (Completely Fair Scheduler) period
      --cpu-quota int                  Limit CPU CFS (Completely Fair Scheduler) quota
      --cpu-rt-period int              Limit CPU real-time period in microseconds
      --cpu-rt-runtime int             Limit CPU real-time runtime in microseconds
  -c, --cpu-shares int                 CPU shares (relative weight)
      --cpus decimal                   Number of CPUs
      --cpuset-cpus string             CPUs in which to allow execution (0-3, 0,1)
      --cpuset-mems string             MEMs in which to allow execution (0-3, 0,1)
```

## Show events

```sh
# use tmux with ctrl+b " to open three sessions
tmux new -s $(basename $(pwd))
```

```sh
# build image
docker build -t cpu-restrictions .  
```

In one tab show the docker events  

```sh
# show a list of events from docker
docker events
```

In another tab show the stats  

```sh
docker stats
```

Execute the container and see it exit with 137  

```sh
# read bogo ops field for number of operation 
docker run -it --rm -e WORKERS=1 -e TIMEOUT=1 --cpus=0.5 --name cpu-restrictions cpu-restrictions 

docker run -it --rm -e WORKERS=1 -e TIMEOUT=10 --cpus=1 --name cpu-restrictions cpu-restrictions     

docker run -it --rm -e WORKERS=2 -e TIMEOUT=10 --cpus=4 --name cpu-restrictions cpu-restrictions 

# using 0 uses all available cpus
docker run -it --rm -e WORKERS=0 -e TIMEOUT=10 --cpus=4 --name cpu-restrictions cpu-restrictions 
```

## Manually testing

```sh
docker run -it --rm --entrypoint /bin/bash --name cpu-restrictions cpu-restrictions 

# stress and stress-ng
stress -c 1 --timeout 10s

stress-ng --cpu 1 --timeout 10 --metrics 
```

## 👀 Resources

* Runtime options with Memory, CPUs, and GPUs [here](https://docs.docker.com/config/containers/resource_constraints/)  
* stress-ng - a tool to load and stress a computer system [here](https://manpages.ubuntu.com/manpages/bionic/man1/stress-ng.1.html)
