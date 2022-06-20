
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

* Copy `./fakelayers/67e2d23c25adb990e3fbddfe03e69be1b45d67f4f19b2b6abf77db9d9125fac4` directory into the unpacked folder
* Change `json` parentid in `67e2d23c25adb990e3fbddfe03e69be1b45d67f4f19b2b6abf77db9d9125fac4` layer folder to last id.
* Change the repositories file to contain `67e2d23c25adb990e3fbddfe03e69be1b45d67f4f19b2b6abf77db9d9125fac4`
* Add `,"67e2d23c25adb990e3fbddfe03e69be1b45d67f4f19b2b6abf77db9d9125fac4/layer.tar"` to manifest.json
* ```sha256sum ./output/buildtest/67e2d23c25adb990e3fbddfe03e69be1b45d67f4f19b2b6abf77db9d9125fac4/layer.tar``` into the list of diff_ids in the sha.json 

```sh
tar -C ./output/buildtest -czf ./output/newimage.tar ./
mkdir -p ./output/buildtest2 && tar -xvf ./output/newimage.tar -C $_
docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
docker rmi $(basename $(pwd)):latest    
docker image load -i ./output/newimage.tar  
docker run --name $(basename $(pwd)) -it $(basename $(pwd)) 
docker inspect $(basename $(pwd)) | jq '.[].Config.Labels'

docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
docker run --name $(basename $(pwd)) --entrypoint bash -it $(basename $(pwd))

ls -l
```

Look at the layer contents  

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
docker stop $(basename $(pwd)) && docker rm $(basename $(pwd))
rm -rf ./output
rm $(basename $(pwd)).tar
docker rmi $(basename $(pwd))
```

## Resources

* https://stackoverflow.com/questions/47249028/how-to-generate-docker-image-layer-diffid