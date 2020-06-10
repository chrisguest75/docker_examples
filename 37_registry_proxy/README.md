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
To get a custom registry cache working you need to override your local DNS to override the external registry name to your local registry cache.  

You will still configure the registry to contact the external resource with credentials defined in the config.yml.

The override can be configured in /etc/hosts instead of DNS
```sh
# create a config_custom.yml file based on config.yml and add.
proxy:
    remoteurl: https://quay.io
    username: [username]
    password: [password]

docker run -d -p 80:5000 --restart=always -v $(pwd)/images:/var/lib/registry -v $(pwd)/config_custom.yml:/etc/docker/registry/config.yml --name registry registry:2
```

On the client machine (one doing pulling)
```sh
# update the daemon to pull from port 80
cat /etc/docker/daemon.json
{
  "insecure-registries" : ["http://quay.io"]
}

# pull image
docker logout quay.io
docker pull quay.io/myorg/myimage
```

Check the logs to verifiy the image pull came from the cache.
```sh
# on registry machine
docker log registry
```

## Considerations
| Pros      | Cons        |  
| ------------- | ------------- |  
| Will cache images from external service within local network | Overriding a public DNS means we lose the fallback if the image pull fails from local |
| Protects against external service failure | Unclear how to control lifetime of specific images, keep forever versus delete after 1 week |
| Simple to setup | Docker client does not handle anything other that docker hub for cache redirect |
|  | |


## Tests
1. Fallback if registry cache fails
1. Storage performance from storage accounts (S3).
1. What happens on push?


