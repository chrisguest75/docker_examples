# README.md
Demonstrate how to run a pull through registry proxy.  

[https://docs.docker.com/registry/recipes/mirror/](https://docs.docker.com/registry/recipes/mirror/)
[https://docs.docker.com/registry/deploying/](https://docs.docker.com/registry/deploying/)

## Run a local registry in mirror mode
Start the local registry in mirror mode.
```sh
mkdir images
docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry  --name registry registry:2

docker pull ubuntu:16.04
docker tag ubuntu:16.04 localhost:5000/my-ubuntu
docker push localhost:5000/my-ubuntu
docker image remove ubuntu:16.04
docker image remove localhost:5000/my-ubuntu
docker pull localhost:5000/my-ubuntu
docker image remove localhost:5000/my-ubuntu
# stop the image and restart it
docker stop registry
docker rm registry

docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry  --name registry registry:2

docker pull localhost:5000/my-ubuntu
docker image remove localhost:5000/my-ubuntu

docker stop registry
docker rm registry
```

You can look at the data store. 
```sh
ls -Rla images
```

## Run a local registry in caching proxy mode
Configure local client to use a local registry 
```sh
#
docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry -v $(pwd)/config.yml:/etc/docker/registry/config.yml --name registry registry:2

cat /etc/docker/daemon.json  
sudo nano /etc/docker/daemon.json
# Paste this into the file
{
  "log-driver": "journald",
  "registry-mirrors": ["http://localhost:5000"]
}

# restart docker
sudo systemctl restart docker   

docker pull docker.io/library/hello-world   

# check the registry logs and see the pull
docker logs registry 

# Logs should contain something like this.  
"GET /v2/library/hello-world/blobs/sha256:bf756fb1ae65adf866bd8c456593cd24beb6a0a061dedf42b26a993176745f6b"
```

If we stop the registry, remove the image we can still pull
```sh
docker rmi docker.io/library/hello-world   
docker stop registry
docker rm registry
docker pull docker.io/library/hello-world   
```

## Custom quay.io
**DOES NOT WORK**
```sh
proxy:
    remoteurl: https://quay.io
    username: [username]
    password: [password]

docker run -d -p 5000:5000 --restart=always -v $(pwd)/images:/var/lib/registry -v $(pwd)/config.yml:/etc/docker/registry/config_custom.yml --name registry registry:2
```