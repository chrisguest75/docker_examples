# DOCKER INIT

Demonstrate `docker init` to create a starter dockerfile.  

TODO:

* mermaid support
* pipenv support

## Version

```sh
docker init --version
```

## Create 

```sh
mkdir -p python_mkdocs
cd python_mkdocs

docker init
```

## Startup

It has been written to share the repo into `/app/docs` folder in.   

```sh
# start
docker compose up --build

# open docs
open http://127.0.0.1:8000/

# troubleshoot 
docker exec -it  python_mkdocs-server-1 /bin/bash
```

## Resources

* docker init docs [here](https://docs.docker.com/reference/cli/docker/init/)
* Streamline Dockerization with Docker Init GA [here](https://www.docker.com/blog/streamline-dockerization-with-docker-init-ga/)