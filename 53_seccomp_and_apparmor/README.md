# README
Demonstrate seccomp and apparmor and how to use them.

TODO:
* The container doesn't seem to be listening to signals so you have to remove the profile to kill it. 

Profiles were based on [../52_dockerslim/README.md](../52_dockerslim/README.md)  

There is another apparmour example [../25_apparmour/README.md](../25_apparmour/README.md)  

## Prereqs

```sh
# use brew on linux
open https://brew.sh/

# use docker-slim to generate them 
brew install docker-slim
```

## Start
```sh
# look for seccomp profile (usually: default)
docker info 

# is linux compiled with seccomp
grep SECCOMP /boot/config-$(uname -r)
```

# Seccomp 
Identify allowd syscalls and whitelist them.

## Build 
```sh
# build the seccomp test container
docker build --no-cache -f Dockerfile -t seccomp-test .

# run the nginx test with default profile (check it works)
docker run -it -d -p 8080:80 --name seccomptest seccomp-test
docker logs seccomptest 

# open the page 
open http://localhost:8080/
curl http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```

## Generate Seccomp Base Profile (using docker-slim)
```sh
# it generates a .slim file and seccomp policies.  
docker-slim profile seccomp-test
docker-slim build --include-path /usr/share/nginx/html --expose 80 --http-probe-cmd / seccomp-test
```

## Seccomp
When using docker-slim look out for the `artifacts.location=` in the logs.  Profiles are created in this loction. 

An example logline is below:
```text
# macosx
cmd=build info=results artifacts.location='/tmp/docker-slim-state/.docker-slim-state/images/fe5d470d3508236b027288e7ed6792fd51c299dac595870f1a170a877b9ff52a/artifacts' 

# linux
cmd=build info=results artifacts.location='/home/linuxbrew/.linuxbrew/Cellar/docker-slim/1.37.0/bin/.docker-slim-state/images/fe5d470d3508236b027288e7ed6792fd51c299dac595870f1a170a877b9ff52a/artifacts' 
```

## Audit 
It is possible to log out the denied syscalls into the syslog.  
```sh
# setup an audit seccomp profile
docker run -it -d -p 8080:80 --security-opt seccomp=./audit-seccomp.json --name seccomptest seccomp-test

# show logs
docker logs seccomptest

open http://localhost:8080/

docker stop seccomptest && docker rm seccomptest

# find the audit events - syscall table https://filippo.io/linux-syscall-table/
cat /var/log/syslog | grep audit  
```

## Run with profile
Run with the original non-slim container with seccomp profile.
```sh
# Running non-slim with profiles
# NOTE: Had to add fstatfs
docker run -it -d -p 8080:80 --security-opt seccomp:./seccomp-test-seccomp.json --name seccomptest seccomp-test

docker logs seccomptest 

open http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```

Now run with the slim container with seccomp profile.
```sh
# Running slim with profiles (with non-root usr this is failing)
docker run -it -d -p 8080:80 --security-opt seccomp:./seccomp-test-seccomp.json --name seccomptest seccomp-test.slim

docker logs seccomptest

open http://localhost:8080/

# cleanup
docker stop seccomptest && docker rm seccomptest
```

# Apparmor 
```sh
# build the container
docker build --no-cache -f Dockerfile -t apparmor-test .

# Running non-slim with profiles
sudo apparmor_parser -r -W ./seccomp-test-apparmor-profile

docker run -it -d -p 8080:80 --security-opt apparmor=seccomp-test-apparmor-profile --name apparmortest apparmor-test

docker logs apparmortest

open http://localhost:8080/

docker stop apparmortest && docker rm apparmortest

# remove profile (this might be required before docker stop)
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

# look at journalctl audit logs
sudo journalctl _TRANSPORT=audit
sudo journalctl _TRANSPORT=audit --since today --no-pager

 /tmp/*   - all files directly in /tmp
 /tmp/*/  - all directories directly in /tmp
 /tmp/**  - all files and directories underneath /tmp
 /tmp/**/ - all directories underneath /tmp

sudo aa-status

# if the docker container cannot be deleted you can remove the troublesome profiles
sudo aa-remove-unknown   
```

You can use a test & edit loop like this. 
```sh
# docker-default
sudo dmesg --clear
docker stop apparmortest && docker rm apparmortest
docker run -it -d -p 8080:80 --security-opt apparmor=docker-default --name apparmortest apparmor-test
dmesg
docker logs apparmortest

open http://localhost:8080/

# seccomp-test-apparmor-profile
sudo dmesg --clear
sudo apparmor_parser -r -W ./seccomp-test-apparmor-profile
docker stop apparmortest && docker rm apparmortest
docker run -it -d -p 8080:80 --security-opt apparmor=seccomp-test-apparmor-profile --name apparmortest apparmor-test
dmesg
docker logs apparmortest

open http://localhost:8080/
```

# Combined apparmor and seccomp

```sh
sudo dmesg --clear
sudo apparmor_parser -r -W ./seccomp-test-apparmor-profile
docker stop apparmortest && docker rm apparmortest
docker run -it -d -p 8080:80 --security-opt apparmor=seccomp-test-apparmor-profile --security-opt seccomp=./audit-seccomp.json --name apparmortest apparmor-test
dmesg
docker logs apparmortest

open http://localhost:8080/

docker logs apparmortest
```


# Checking capabilities
https://github.com/genuinetools/amicontained/
https://hub.docker.com/r/nodyd/bsidesmuc2020
```sh
docker run --rm -it r.j3ss.co/amicontained -d bash

```

# Resources 
## Seccomp
* Docker seccomp docs [here](https://docs.docker.com/engine/security/seccomp/)  
https://docs.docker.com/engine/security/apparmor/
* https://martinheinz.dev/blog/41
* Issue with dockerslim fstatfs https://githubmemory.com/repo/docker-slim/docker-slim/issues/182
* Discussion on seccomp [here](https://sysdig.com/blog/selinux-seccomp-falco-technical-discussion/)
* Syscall id table [here](https://raw.githubusercontent.com/torvalds/linux/master/arch/x86/entry/syscalls/syscall_64.tbl)
* Another syscall table [here](https://filippo.io/linux-syscall-table/)
* https://www.redhat.com/sysadmin/container-security-seccomp


## Apparmor
* https://askubuntu.com/questions/486150/evince-error-while-loading-shared-libraries-permission-denied
* https://en.opensuse.org/SDB:AppArmor_geeks
* https://wiki.ubuntu.com/DebuggingApparmor
* https://blog.jessfraz.com/post/how-to-use-new-docker-seccomp-profiles/
* https://doc.opensuse.org/documentation/leap/security/html/book-security/cha-apparmor-commandline.html
* https://github.com/moby/moby/blob/master/contrib/apparmor/template.go
* https://danwalsh.livejournal.com/80232.html
* https://stackoverflow.com/questions/43467670/which-capabilities-can-i-drop-in-a-docker-nginx-container
* https://blog.strandboge.com/2014/06/06/application-isolation-with-apparmor-part-iv/
* https://presentations.nordisch.org/apparmor/#/
* https://nordisch.org/posts/nicer-apparmor-profile-names/

