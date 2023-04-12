# Docker Context

Demonstrate how to work with Docker context.  

TODO:

* Test if modifying the dockerignore causes a cache invalidation in the correct places.  

## 📋 Script to follow

* Show a docker context issue (large files)  
* Using .dockerignore to prevent bloating the docker context and increasing build times.  
* Use a selective whitelist in the context.  

ℹ️ NOTES:

* If you're building an image and installing `node_modules` inside the container you should using a `.dockerignore` file.  

## Large file and folders

```sh
# make a large file
mkfile 200m ./large_file.bin
```

### No Ignore

```sh
# rebuild the image (included in context)
docker build --no-cache -f Dockerfile.bash -t scratchtest .
```

### Ignored

```sh
# rebuild (it will not copy the 200mb file into the context)
docker build --no-cache -f ./Dockerfile.ignored -t scratchtest .
```

## Selective inclusion (whitelist)

```sh
# exclude everything and select some folders
docker build --no-cache -f Dockerfile.whitelist -t whitelisttest ../
```

## Resources

* How to specify different .dockerignore files for different builds in the same project? [here](https://stackoverflow.com/questions/40904409/how-to-specify-different-dockerignore-files-for-different-builds-in-the-same-pr)
* dockerignore file to ignore everything except two folders and their contents is not working [here](https://github.com/docker/compose/issues/6024)
