# README
Demonstrate seccomp and apparmor and how to use them.

Based on [../52_dockerslim/README.md](../52_dockerslim/README.md_)  
## Prereqs
```sh
https://brew.sh/

# use docker-slim to generate them 
brew install docker-slim
```
## Start
```sh
# look for seccomp profile
docker info 

# on linux
grep SECCOMP /boot/config-$(uname -r)
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

## Seccomp
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

## Audit 
It is possible to log out syscalls into the syslog.  
```sh
# setup an audit seccomp profile
docker run -it -d -p 8080:80 --security-opt seccomp=./audit-seccomp.json --name seccomptest seccomp-test

docker logs seccomptest

open http://localhost:8080/

docker stop seccomptest && docker rm seccomptest

# find the audit events - syscall table https://filippo.io/linux-syscall-table/
cat /var/log/syslog | grep audit  
```

## Apparmor 
```sh
# Running non-slim with profiles
sudo apparmor_parser -r -W ./seccomp-test-apparmor-profile

docker run -it -d -p 8080:80 --security-opt apparmor=seccomp-test-apparmor-profile --name apparmortest seccomp-test

docker logs apparmortest

open http://localhost:8080/

docker stop apparmortest && docker rm apparmortest
sudo apparmor_parser -R ./seccomp-test-apparmor-profile

```

## Troubleshooting Apparmor
```sh
# install the aa-* tools
sudo apt install apparmor-utils  

# check the loaded profiles
sudo apparmor_status  

sudo aa-logprof
cat /var/log/syslog | grep audit     



sudo apparmor_parser -r -W ./seccomp-test-apparmor-profile
docker stop apparmortest && docker rm apparmortest
docker run -it -d -p 8080:80 --security-opt apparmor=seccomp-test-apparmor-profile --name apparmortest seccomp-test
cat /var/log/syslog | grep audit     
```



# Resources 
* Docker seccomp docs [here](https://docs.docker.com/engine/security/seccomp/)  
https://docs.docker.com/engine/security/apparmor/
* https://martinheinz.dev/blog/41
* Issue with dockerslim fstatfs https://githubmemory.com/repo/docker-slim/docker-slim/issues/182
https://sysdig.com/blog/selinux-seccomp-falco-technical-discussion/

https://askubuntu.com/questions/486150/evince-error-while-loading-shared-libraries-permission-denied

https://wiki.ubuntu.com/DebuggingApparmor

https://blog.jessfraz.com/post/how-to-use-new-docker-seccomp-profiles/

https://raw.githubusercontent.com/torvalds/linux/master/arch/x86/entry/syscalls/syscall_64.tbl

https://filippo.io/linux-syscall-table/

https://doc.opensuse.org/documentation/leap/security/html/book-security/cha-apparmor-commandline.html