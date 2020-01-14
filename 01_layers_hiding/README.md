# Example 1 - Layers, Hiding and Squashing
Demonstrates how layers are stored, files are hidden and can be squashed.  

## Script to follow
Demonstrate adding a file to a scratch base.    
Unpack the image tar and see how the file is stored in a layer. 
Also demonstrates how the overwritten files still exist in the earlier layers. 

```sh
docker build -t scratchtest .
docker image save -o ./scratchtest.tar scratchtest

mkdir ./scratchtest
tar -xvf scratchtest.tar -C ./scratchtest
code ./scratchtest
```

Squashing relies on experimental features being enabled. 
On MacOSX you can do this through the daemon preferences in the GUI 

NOTE: Squashing provides no layer caching benefits.

```sh
docker build --squash -t squashtest .      
docker image save -o ./squashtest.tar squashtest 

mkdir ./squashtest 
tar -xvf squashtest.tar -C ./squashtest

```