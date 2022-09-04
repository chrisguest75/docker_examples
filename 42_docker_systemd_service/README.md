# README

Demonstrate how to use docker containers as `systemd` services.  

## Configure

Create configuration for the example service.  

```sh
# generate config from shell variables $USER and $PWD
cat ./chrisguest75_dockerservice.service.template | envsubst > ./chrisguest75_dockerservice.service 
```

## Install

```sh
# install the service by symlinking
sudo ln -s $(pwd)/chrisguest75_dockerservice.service /etc/systemd/system/chrisguest75_dockerservice.service  

# Start the service
sudo systemctl start chrisguest75_dockerservice 

# get status of service
systemctl status chrisguest75_dockerservice 

# find container
docker ps --filter 'name=/chrisguest75_dockerservice.service'  
```

## Test 

```sh
# test the webservice
curl -vvvv localhost:8080 
xdg-open http://localhost:8080

# stop service
sudo systemctl stop chrisguest75_dockerservice 

# container should be stopped
docker ps --filter 'name=/chrisguest75_dockerservice.service'  

# test should fail
curl -vvvv localhost:8081/clientpath  

# start service
sudo systemctl start chrisguest75_dockerservice

# logs for service
journalctl -b -u chrisguest75_dockerservice.service --no-pager
```

## 🧼 Cleanup

```sh
# stop the service
systemctl stop chrisguest75_dockerservice 
```

```sh
# remove the service
sudo rm /etc/systemd/system/chrisguest75_dockerservice.service  
```

## 👀 Resources

* [systemd wiki](https://www.freedesktop.org/wiki/Software/systemd/)  
* [running-docker-containers-with-systemd](https://blog.container-solutions.com/running-docker-containers-with-systemd)  
* [run-docker-container-as-service](https://www.jetbrains.com/help/youtrack/standalone/run-docker-container-as-service.html)  

