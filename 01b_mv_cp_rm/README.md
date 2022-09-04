# Mv, Rm, Sh

Try copying files in a scratch container.  

ℹ️ NOTE: Probably easier to build a rootfs and copy the files into the tar.  

TODO:

1. ** Not working!! ** Building a simple container with mv, rm, sh.  Probably missing libs. 
1. How do I debug what is missing? 

## 📋 Script to follow

Demonstrate removing files

```sh
# build image
docker build -t scratchtest .
# run image
docker run -it --entrypoint=/bin/sh scratchtest
```
