# README

Demonstrate how Docker deals with an out-of-memory issue  

Build the container and execute with the constraints  

TODO:

* cgget does not work on mac
* sysdig example
* show mem allocation profiling.
* process tree with memory allocations.
* finding out how much memory a container has been allocated from inside it.

## Show OOM events

```sh
# use tmux with ctrl+b " to open three sessions
tmux new -s $(basename $(pwd))
```

```sh
# build image
docker build -t oom_checker .  
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
docker run -it --rm --memory=400m --name oom_checker oom_checker 
```

Events should show something like this.

```log
2022-11-11T18:09:20.269340406Z container oom 68801ac6fef5af345372c254466ef633b4846cc88e7d6ddf28a8f58c30a9736d (image=oom_checker, name=oom_checker)
```

You can try to blow the memory of the container whilst in the shell but it doesn't seem to get OOM killed.  

```sh
docker run -it --rm --entrypoint /bin/bash --name oom_checker oom_checker

# this will not kill the container
/scripts/hogger.sh
```

## OOM events on Docker for Desktop host

To enter the host machine on Docker for Desktop.  

```sh
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

```sh
dmesg
```

You should see messages like

```log
[89942.480388] Memory cgroup out of memory: Kill process 46211 (process) score 561 or sacrifice child
[89942.482095] Killed process 46433 (process) total-vm:536552kB, anon-rss:12012kB, file-rss:53740kB, shmem-rss:4kB
[89942.488774] oom_reaper: reaped process 46433 (chrome), now anon-rss:0kB, file-rss:0kB, shmem-rss:4kB
```

## Sysdig capture

```sh
docker run -itd --rm --memory=500m --name oom_checker oom_checker
watch -n 1 docker ps 

sudo sysdig container.id=$(docker ps -aqf "name=oom_checker")

docker run -d -v $(pwd):/captures -p8080:3000 sysdig/sysdig-inspect:latest
```

## 👀 Resources

* Runtime options with Memory, CPUs, and GPUs [here](https://docs.docker.com/config/containers/resource_constraints/)  
* stress-ng - a tool to load and stress a computer system [here](https://manpages.ubuntu.com/manpages/bionic/man1/stress-ng.1.html)  
