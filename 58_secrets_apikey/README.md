# README

Demonstrate how to use a secrets mount during build (requires buildkit).  

## 🏠 Build

Build the image using secrets.  

```sh
# build (add --progress=plain to debug)
docker build --secret id=secretkey,src=secret.key --progress=plain --no-cache -t secretbuild_stage1 --target STAGE1 .

# this will fail as the secret does not exist
docker build --secret id=secretkey,src=secret.key --progress=plain --no-cache -t secretbuild_stage2 --target STAGE2 .
```

## 🔍 Investigate

Look at built containers.  

```sh
# run
docker run -it --name secretbuild_stage1 --rm secretbuild  
```

Have a look inside.  

```sh
# debug
docker run -it --rm --name secretbuild_stage1 --entrypoint "/bin/bash" secretbuild

# inside container
> ls -l 

# this file shows that secret can be stored in image if you do stupid things.
> cat ./secretkey
```

## 👀 Resources

* Build images with BuildKit using ssh [here](https://docs.docker.com/develop/develop-images/build_enhancements/#using-ssh-to-access-private-data-in-builds)
