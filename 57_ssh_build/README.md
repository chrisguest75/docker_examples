# README

Demonstrate how to use an ssh mount during build.

## Build

```sh
# build (add --progress=plain to debug)
# on linux DOCKER_BUILDKIT=1 is required, docker desktop it is default enabled
DOCKER_BUILDKIT=1 docker build --ssh default --progress=plain --no-cache -t sshbuild .
DOCKER_BUILDKIT=1 docker build --ssh default --progress=plain -t sshbuild .

#DOCKER_BUILDKIT=1 docker build --ssh ~/.ssh/id_rsa --progress=plain --no-cache -t sshbuild .

# debug
docker run -it --rm --name sshbuild --entrypoint "/bin/bash" sshbuild
```

## Resources

* Build images with BuildKit [here](https://docs.docker.com/develop/develop-images/build_enhancements/#using-ssh-to-access-private-data-in-builds)  

ssh-agent and docker for mac not working properly
https://github.com/docker/for-mac/issues/4842

* Build secrets and SSH forwarding in Docker 18.09 [here](https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066)


https://stackoverflow.com/questions/9960897/why-doesnt-my-ssh-key-work-for-connecting-to-github
