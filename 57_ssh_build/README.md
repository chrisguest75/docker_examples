# README

Demonstrate how to use an ssh mount during build.

## Build

```sh
# build (add --progress=plain to debug)
docker build --progress=plain --no-cache -t sshbuild .
docker build --progress=plain -t sshbuild .

# debug
docker run -it --rm --name sshbuild --entrypoint "/bin/bash" sshbuild
```

## Resources

* Build images with BuildKit [here](https://docs.docker.com/develop/develop-images/build_enhancements/#using-ssh-to-access-private-data-in-builds)  

