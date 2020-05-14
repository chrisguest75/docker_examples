# README
Demonstrates using dockle to find issues with images.  

## What is dockle?
Container Image Linter for Security, Helping build the Best-Practice Docker Image

Goto [Dockle](https://github.com/goodwithtech/dockle)  

## TODO  
!. Show how to fix the issues raised

## Installation
Install 
```sh
brew install goodwithtech/r/dockle
```

## Test
```sh
docker build -t dockletest .
dockle dockletest
```

Example output
```log
FATAL   - DKL-DI-0005: Clear apt-get caches
        * Use 'rm -rf /var/lib/apt/lists' after 'apt-get install' : /bin/sh -c apt-get update && apt-get install curl -y
WARN    - CIS-DI-0001: Create a user for the container
        * Last user should not be root
WARN    - DKL-DI-0006: Avoid latest tag
        * Avoid 'latest' tag
INFO    - CIS-DI-0005: Enable Content trust for Docker
        * export DOCKER_CONTENT_TRUST=1 before docker pull/build
INFO    - CIS-DI-0006: Add HEALTHCHECK instruction to the container image
        * not found HEALTHCHECK statement
INFO    - CIS-DI-0008: Confirm safety of setuid/setgid files
        * setuid file: bin/mount urwxr-xr-x
        * setuid file: usr/bin/gpasswd urwxr-xr-x
        * setuid file: bin/umount urwxr-xr-x
        * setgid file: sbin/unix_chkpwd grwxr-xr-x
        * setgid file: sbin/pam_extrausers_chkpwd grwxr-xr-x
        * setuid file: usr/bin/chsh urwxr-xr-x
        * setuid file: usr/bin/passwd urwxr-xr-x
        * setuid file: usr/bin/chfn urwxr-xr-x
        * setgid file: usr/bin/expiry grwxr-xr-x
        * setuid file: bin/su urwxr-xr-x
        * setgid file: usr/bin/chage grwxr-xr-x
        * setuid file: usr/bin/newgrp urwxr-xr-x
        * setgid file: usr/bin/wall grwxr-xr-x
```