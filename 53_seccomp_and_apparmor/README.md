# README
Demonstrate seccomp and apparmor and how to use them.

Based on [../52_dockerslim/README.md](../52_dockerslim/README.md_)  

## Start
```sh
# look for seccomp profile
docker info 
```

## Prereqs
```sh
https://brew.sh/

# use docker-slim to generate them 
brew install docker-slim
```

## Build 
```sh
# build the container
docker build --no-cache -f Dockerfile -t seccomp-test .

# run the nginx test
docker run -it -d -p 8080:80 --name seccomptest seccomp-test
docker logs seccomptest 

# open the page
open http://localhost:8080/
curl http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```

## Generate Profile
```sh
# it generates a .slim file and seccomp policies.  
docker-slim profile seccomp-test
docker-slim build --include-path /usr/share/nginx/html --expose 80 --http-probe-cmd / seccomp-test
```

## Seccomp & Apparmor
When using docker-slim look out for the artifacts location in the logs.  This is where the profiles are output. 

```text
# macosx
cmd=build info=results artifacts.location='/tmp/docker-slim-state/.docker-slim-state/images/fe5d470d3508236b027288e7ed6792fd51c299dac595870f1a170a877b9ff52a/artifacts' 

# linux
cmd=build info=results artifacts.location='/home/linuxbrew/.linuxbrew/Cellar/docker-slim/1.37.0/bin/.docker-slim-state/images/fe5d470d3508236b027288e7ed6792fd51c299dac595870f1a170a877b9ff52a/artifacts' 
```

```sh
# Running non-slim with profiles
# NOTE: Had to add fstatfs
docker run -it -d -p 8080:80 --security-opt seccomp:./seccomp-test-seccomp.json --name seccomptest seccomp-test

docker logs seccomptest 

open http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```


```sh
# Running slim with profiles
docker run -it -d -p 8080:80 --security-opt seccomp:./seccomp-test-seccomp.json --name seccomptest seccomp-test.slim

docker logs seccomptest

open http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```



# Resources 
* Docker seccomp docs [here](https://docs.docker.com/engine/security/seccomp/)  
* https://martinheinz.dev/blog/41

