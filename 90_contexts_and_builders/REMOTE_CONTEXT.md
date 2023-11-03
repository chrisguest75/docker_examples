# REMOTE BUILDS

Use a shared docker socket on another machine.  

TODO:

* sockets vs tcp
* How is builder different to a context?  It seems that you get builders per context.  
  * Run docker buildx ls with a remote context that is not connected and you'll see.

## SSH

You'll need to copy over the key to the host and use `ssh-agent`.  

## Contexts

```sh
# existing contexts
docker context ls 

# createe context for remote socket
docker context create --docker host=ssh://user@192.168.1.100 --description="Remote engine" remote-monga

# switch to context
docker context use remote-monga

# see the remote version and images
docker images 
docker version

# build an images
docker buildx build --progress=plain -f Dockerfile.processor -t processor .

# you can run the remote container.
docker run --rm -it processor
docker context use default
```

## Running nginx

```sh
# switch to context
docker context use remote-monga
docker context use default

docker run -p 8080:80 --name nginx --rm -it nginx:1.23.3 
# remote 
curl http://192.168.1.100:8080
# local
curl http://0.0.0.0:8080

# switch back
docker context use default
```

## Resources

* [chrisguest75/sysadmin_examples/14_interrogate_resources/NETWORK.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/14_interrogate_resources/NETWORK.md)
* [chrisguest75/sysadmin_examples/08_ssh/README.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/08_ssh/README.md)
* Remote driver [here](https://docs.docker.com/build/drivers/remote/)
* dockerd [here](https://docs.docker.com/engine/reference/commandline/dockerd)
* Forwarding the Docker Socket over SSH [here](https://medium.com/@dperny/forwarding-the-docker-socket-over-ssh-e6567cfab160)
* Configure remote access for Docker daemon [here](https://docs.docker.com/config/daemon/remote-access/)
* Protect the Docker daemon socket [here](https://docs.docker.com/engine/security/protect-access/)
