# README.md
Demonstrate using AppArmor to prevent a ping from inside the container. 

TODO: 
1. Give a better example of enforcement.  
1. Policy doesn't seem to do the right thing right now.  

Prerequisites 
```sh
apt-get install apparmor-utils
```

## Build and run
```
docker build -f Dockerfile -t apparmor .          
docker run -it --rm apparmor 
```

```sh
sudo aa-status

# List profiles
ls /etc/apparmor.d
```

An example policy [25_apparmor.policy](./25_apparmor.policy)

### Run unconstrained
Show process is constrained by docker-default
```sh
docker run --rm -it --entrypoint=/bin/bash apparmor

# on host
aa-status
```

Show process is now not protected by a profile.  
```sh
docker run --rm -it --entrypoint=/bin/bash --security-opt apparmor=unconfined apparmor

# on host
aa-status
```

Enable a policy (not working yet)
```sh
sudo cp 25.apparmor.my_apparmor_policy /etc/apparmor.d              
apparmor_parser -r -W /etc/apparmor.d/25.apparmor.my_apparmor_policy
sudo systemctl restart apparmor
sudo aa-status
docker run --rm -it --entrypoint=/bin/bash --security-opt apparmor=my_apparmor_policy apparmor

# another shell
sudo aa-status
  apparmor module is loaded.
  18 profiles are loaded.
  18 profiles are in enforce mode.
    ...
    my_apparmor_policy
  0 profiles are in complain mode.
  1 processes have profiles defined.
  1 processes are in enforce mode.
     my_apparmor_policy (12787) 
  0 processes are in complain mode. 
  0 processes are unconfined but have a profile defined.

# It doesn't seem to enforce
docker run --rm -it --security-opt apparmor=my_apparmor_policy apparmor 
```
