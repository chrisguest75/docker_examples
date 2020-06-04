# README.md
Demonstrate how to run a pull through registry proxy.  

[https://docs.docker.com/registry/recipes/mirror/](https://docs.docker.com/registry/recipes/mirror/)
[https://docs.docker.com/registry/deploying/](https://docs.docker.com/registry/deploying/)

## Run a local registry
Start the local registry.
```sh
mkdir images
docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry -v $(pwd)/config.yml:/etc/docker/registry/config.yml --name registry registry:2

docker pull ubuntu:16.04
docker tag ubuntu:16.04 localhost:5000/my-ubuntu
docker push localhost:5000/my-ubuntu
docker image remove ubuntu:16.04
docker image remove localhost:5000/my-ubuntu

# stop the image and restart it
docker stop registry

docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry -v $(pwd)/config.yml:/etc/docker/registry/config.yml --name registry registry:2

docker stop registry
docker rm registry
```

You can look at the data store. 
```sh
ls -Rla images
```

Configure local client to use a local registry 
```sh
cat /etc/docker/daemon.json  

{
  "log-driver": "journald",
  "registry-mirrors": ["http://localhost:5000"]
}

# restart docker
sudo systemctl restart docker   

docker pull docker.io/library/hello-world   

# check the registry logs and see the pull
docker logs registry 
```

If we stop the registry, remove the image we can still pull
```sh
docker rmi docker.io/library/hello-world   
docker pull docker.io/library/hello-world   
```

