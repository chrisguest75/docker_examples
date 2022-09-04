# Docker Context

Show a docker context issue (large files)  

## 📋 Script to follow

Show a docker context issue (large files)  
Using .dockerignore to prevent bloating the docker context and increasing build times.  

ℹ️ NOTE: If you're building an image and installing `node_modules` inside the container you should using a `.dockerignore` file.    

```sh
# build the image  
docker build --no-cache -t scratchtest .
```

### No ignore

```sh
# make a large file
mkfile 200m ./large_file.bin

# rebuild the image (included in context)
docker build --no-cache -t scratchtest .
```

> Sending build context to Docker daemon  3.072kB  
> Step 1/3 : FROM bash:5.0.7 as bash

### Ignore

```sh
# add file to .dockerignore
echo large_file.bin > ./.dockerignore  

# rebuild (it will not copy the 200mb file into the context)
docker build --no-cache -t scratchtest .
```

> Sending build context to Docker daemon  209.7MB  
> Step 1/3 : FROM bash:5.0.7 as bash

