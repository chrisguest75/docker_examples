# Docker Build Examples and Demos
A repository for showing examples of how containers are built. 

## Example 1 - Layers
Demonstrates how layers are stored.  
Steps [README.md](./step1/README.md)  


## Example 2 - Kernel versions
Demonstrates how kernel versions are different for build and execution.  
Steps [README.md](./step2/README.md)  


## Example 3 - Buildargs 
Demonstrate how buildargs are stored in the image  
Steps [README.md](./step3/README.md)  


## Example 4 - Docker Context 
Show a docker context issue (large files)  
Steps [README.md](./step4/README.md)  


## Example 5 - Root user 
Demonstrate root user  
Steps [README.md](./step5/README.md)  


## Example 6 - Multistage 
Demonstrate multistage build  
Steps [README.md](./step6/README.md)  

## TODO
1. Build a rootfs container
1. Show patching a container to fix an issue reported by GCR
1. Show how multistage builds work 
1. Show a buildkit example - two containers building simultaneously 
1. Cache invalidation - package managers 
1. Ordering of layers
1. Squashing
1. Secrets
1. onbuild
1. read only containers
1. cmd line containers