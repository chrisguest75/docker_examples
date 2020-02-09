# Example 1b - Mv, Rm, Sh

# TODO
1. ** Not working!! ** Building a simple container with mv, rm, sh.  Probably missing libs. 
1. How do I debug what is missing? 

## Script to follow
Demonstrate removing files

```sh 
docker build -t scratchtest .
docker run -it --entrypoint=/bin/sh scratchtest
```

