# README.md
Demonstrate how to inject a sidecar container with some extra debugging tools 

## Script to follow

### Start nodejs
Build and execute the container with some code we want to debug.
```sh
# simple nodejs app
docker build -f code.Dockerfile -t code_sidecar . 
docker run -d --read-only -it --rm --name code_sidecar code_sidecar  
docker exec -it  $(docker ps --filter name=code_sidecar -q) /bin/bash             
```

### Start inspection container
Inject the container with some extra debugging tools
```sh
docker build -f debug.Dockerfile -t debug_sidecar . 
docker run --privileged -it --rm --pid=container:$(docker ps --filter name=code_sidecar -q) --name debug_sidecar --entrypoint /bin/bash debug_sidecar  
```

Show all processes in the namespace
```sh
# should see node process in other container
ps -aux

# pid of current bash
echo $BASHPID 

# get pid of node app and look at open files.
lsof -p 1
```

## Debug nginx
### Start nginx
Build and execute the container with some code we want to debug.
```sh
# simple nginx
docker run -d -p 8080:80 -it --rm --name nginx_sidecar nginx:1.21.0  
docker exec -it  $(docker ps --filter name=nginx_sidecar -q) /bin/sh             
```
### Start inspection container
Inject the container with some extra debugging tools
```sh
docker build -f debug.Dockerfile -t debug_sidecar . 
docker run --privileged -it --rm --pid=container:$(docker ps --filter name=nginx_sidecar -q) --name debug_sidecar --entrypoint /bin/bash debug_sidecar  
```

Show all processes in the namespace
```sh
# should see node process in other container
ps -aux

# pid of current bash
echo $BASHPID 

# get pid of nginx app and look at open files.
lsof -p 1

# you can view the filesystem through the path.
ls /proc/1/root

# edit the html in the nginx container
nano /proc/1/root/usr/share/nginx/html/index.html 
```

In a new terminal 
```sh
curl 0.0.0.0:8080  
```

### Strace nginx
```sh
# on debug container change worker_processes from auto to 1
nano /proc/1/root/etc/nginx/nginx.conf 
> worker_processes  1;

# in the nginx contaienr
nginx -s reload

# unfortunately you don't seem to be able to reload from debug container
/proc/1/root/usr/sbin/nginx -s reload

# put strace on single worker remaining pidof
strace -p 128 

# now perform request
curl 0.0.0.0:8080  
```

## Clean up
```sh
docker stop $(docker ps --filter name=code_sidecar -q)           
```


          