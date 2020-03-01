# README.md
Demonstrates a readonly container. 

```sh
docker build -f Dockerfile -t readonlytest . 
docker run --read-only -it --rm --entrypoint /bin/bash readonlytest  
```

Fails with readonly filesystem failure.
```sh
apt install htop
```