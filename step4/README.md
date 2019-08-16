# Script to follow
Show a docker context issue (large files)

```
docker build --no-cache -t scratchtest .
mkfile 200m ./large_file.bin
docker build --no-cache -t scratchtest .
echo large_file.bin > ./.dockerignore  
docker build --no-cache -t scratchtest .
```

# Examples

```
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM bash:5.0.7 as bash

Sending build context to Docker daemon  209.7MB
Step 1/3 : FROM bash:5.0.7 as bash
```
