# README

Demonstrate how to use a secrets mount during build (requires buildkit).

## Build

```sh
# build (add --progress=plain to debug)
docker build --secret id=secretkey,src=secret.key --progress=plain --no-cache -t secretbuild_stage1 --target STAGE1 .
# this will fail as the secret does not exist
docker build --secret id=secretkey,src=secret.key --progress=plain --no-cache -t secretbuild_stage2 --target STAGE2 .

# run
docker run -it --name secretbuild_stage1 --rm secretbuild  

# debug
docker run -it --rm --name secretbuild_stage1 --entrypoint "/bin/bash" secretbuild
ls -l 
# this file shows that secret can be stored in image if you do stupid things.
cat ./secretkey
```

## Resources

* Build images with BuildKit [here](https://docs.docker.com/develop/develop-images/build_enhancements/#using-ssh-to-access-private-data-in-builds)
