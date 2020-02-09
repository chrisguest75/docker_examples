# Example 1 - Layers, Hiding and Squashing
Demonstrates how layers are stored, files are hidden and can be squashed.  

We create a scratch container and copy some files in layers overwriting previous layers.

## Script to follow
Demonstrate adding a file to a scratch base.    
Unpack the image tar and see how the file is stored in a layer. 
Also demonstrates how the overwritten files still exist in the earlier layers. 

```sh
# Build the image
docker build -t scratchtest .
# Save a local copy of it
docker image save -o ./scratchtest.tar scratchtest
```

Now examine the layers  
```sh
# Unpack the image
mkdir -p ./scratchtest && tar -xvf scratchtest.tar -C $_
# Examine the structure
ls -l ./scratchtest
```

The directory structure should look something like this.  
```sh
./scratchtest
├── [        160]  2febfdaf2bda9c61d12f88721c1e599496e5d7688f6fea1387038118f97b1868
│   ├── [          3]  VERSION
│   ├── [        477]  json
│   └── [       2048]  layer.tar
├── [        160]  5b7191f5265833024afcd11550f06858cd6a5e653f996b791f817ac90ce985cf
│   ├── [          3]  VERSION
│   ├── [       1233]  json
│   └── [       2048]  layer.tar
├── [        160]  6454d6943bc3b514d62a1fd67b386dc24d3794f5057c07ac3a9f719292029e5c
│   ├── [          3]  VERSION
│   ├── [        477]  json
│   └── [       2048]  layer.tar
├── [        160]  6c34d6933bfd979a209fc7532f0c5f9f19153763bc196e60d5de101805f26a40
│   ├── [          3]  VERSION
│   ├── [        477]  json
│   └── [       2048]  layer.tar
├── [        160]  75cb7b527842f8ed75560c37aab2363e5ca862723257f49ce0bea0d5b761e862
│   ├── [          3]  VERSION
│   ├── [        401]  json
│   └── [       2048]  layer.tar
├── [       2452]  957174b2d0991c63c497d275efbc3e039e35c93f717ae36207014c14cba71090.json
├── [        515]  manifest.json
└── [         94]  repositories

5 directories, 18 files
```

Look at the contents  
```sh
# extract layer tars
find * -iname "layer.tar*" -execdir mkdir layer \;                         
find * -iname "layer.tar*" -execdir tar -xvf {} -C ./layer \;    

# Use editor to examine contents of the json files and untared layers.
code ./scratchtest
```

Clean up   
```sh
# Remove files
rm -rf ./scratchtest
rm scratchtest.tar
docker rmi scratchtest
```

## Squashing
Squashing relies on experimental features being enabled. 
On MacOSX you can do this through the daemon preferences in the GUI 

NOTE: Squashing provides no layer caching benefits.

```sh
docker build --squash -t squashtest .      
docker image save -o ./squashtest.tar squashtest 

mkdir ./squashtest 
tar -xvf squashtest.tar -C ./squashtest

```