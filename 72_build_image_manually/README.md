
# 72 Building images manually

Demonstrates how to build images manually.  

TODO:

* retar up the image and import
* copy a new layer and retar and import
* change a label

## 📋 Script to follow

```sh
# on linux (for 1.4 syntax)
export DOCKER_BUILDKIT=1  

# Build the image
docker build --progress=plain --label "mylabel=myvalue" -f Dockerfile.modify -t $(basename $(pwd)) .

# run the image
docker rm $(basename $(pwd)) 
docker run --name $(basename $(pwd)) -it $(basename $(pwd))
docker inspect $(basename $(pwd)) | jq '.[].Config.Labels'

# Save a local copy of it
mkdir -p ./output
docker image save -o ./output/$(basename $(pwd)).tar $(basename $(pwd))
```

Extract the image  

```sh
# Unpack the image
mkdir -p ./output/buildtest && tar -xvf ./output/$(basename $(pwd)).tar -C $_
# Examine the structure
ls -l ./output/buildtest
```

Repack and reimport  

```sh
# rebuild image
tar -C ./output/buildtest -czf ./output/newimage.tar ./
mkdir -p ./output/buildtest2 && tar -xvf ./output/newimage.tar -C $_
docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
docker rmi $(basename $(pwd)):latest    
docker image load -i ./output/newimage.tar  
docker run --name $(basename $(pwd)) -it $(basename $(pwd))
```

Modify and reimport  

Go modify the label value in the manifest file in root of ` ./output/buildtest`  

```json
    "Labels": {
      "mylabel": "modifiedvalue"
    },
```

Rebuild it  

```sh
tar -C ./output/buildtest -czf ./output/newimage.tar ./
mkdir -p ./output/buildtest2 && tar -xvf ./output/newimage.tar -C $_
docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
docker rmi $(basename $(pwd)):latest    
docker image load -i ./output/newimage.tar  
docker run --name $(basename $(pwd)) -it $(basename $(pwd)) 
docker inspect $(basename $(pwd)) | jq '.[].Config.Labels'
```

Insert layer and rebuild it  

```sh
tar -C ./output/buildtest -czf ./output/newimage.tar ./
mkdir -p ./output/buildtest2 && tar -xvf ./output/newimage.tar -C $_
docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
docker rmi $(basename $(pwd)):latest    
docker image load -i ./output/newimage.tar  
docker run --name $(basename $(pwd)) -it $(basename $(pwd)) 
docker inspect $(basename $(pwd)) | jq '.[].Config.Labels'
```









Look at the contents  

```sh
# extract layer tars
find ./output/buildtest/* -iname "layer.tar*" -execdir mkdir layer \;                         
find ./output/buildtest/* -iname "layer.tar*" -execdir tar -xvf {} -C ./layer \;    

# Use editor to examine contents of the json files and untared layers.
code ./output/buildtest
```

Clean up  

```sh
# Remove files
rm -rf ./hidingtest
rm $(basename $(pwd)).tar
docker rmi $(basename $(pwd))
```
