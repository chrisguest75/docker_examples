# README

Demonstrate an out of memory issue  

Build the container and execute with the constraints  

TODO:

* sysdig example
* show mem allocation profiling.
* process tree with memory allocations.
* finding out how much memory a container has been allocated from inside it. 

## Show OOM events

```sh
docker build -t oom .   
```

In one tab show the docker events

```sh
docker events
```

In another tab show the stats

```sh 
docker stats
```

Execute the container and see it exit with 137

```sh
docker run -it --rm --memory=400m --name oom oom 
```


Events should show something like this.

```log
2019-10-10T22:57:33.882123400+01:00 container die 9fce35c576814e8c520f1bb632aa1425d2eaf3cee603a9a12fe5a8cd71628d7c (exitCode=137, image=oom, name=oom)
```

You can try to blow the memory of the container whilst in the shell but it doesn't seem to get OOM killed. 

```sh
docker run -it --rm --entrypoint /bin/bash --name oom oom       
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
docker run -itd --rm --memory=500m --name oom oom
watch -n 1 docker ps 
```

```sh
sudo sysdig container.id=$(docker ps -aqf "name=oom")
```

```sh
docker run -d -v $(pwd):/captures -p8080:3000 sysdig/sysdig-inspect:latest
```

## 👀 Resources