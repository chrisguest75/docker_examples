# README
Demonstrate how to use a build pack to build a simple Python container

TODO: 
* Why are the images so big?
* How quickly can they be rebuilt?
* Can we run tests inside them?

## Install 
Installing pack cli tool [instructions](https://buildpacks.io/docs/tools/pack/)

```sh
#macosx or linux 
brew install buildpacks/tap/pack
```

## Inspecting Buildpacks
```sh
# what build pack builders exist?
pack builder suggest

# inspect a buildpack builder
pack builder inspect heroku/buildpacks:20  
```

## Building and running
```sh
# build the container
pack build buildpackexample --builder gcr.io/buildpacks/builder:v1 --env GOOGLE_ENTRYPOINT="python main.py" 
# run the container
docker run buildpackexample    
```

## Looking inside
Use dive tool [README.md](../30_dive_ci/README.md) 
```sh
dive buildpackexample    
```

# Resources 
* [buildpacks](https://buildpacks.io/)  
* [samples](https://github.com/buildpacks/samples)  
* [google samples](https://github.com/GoogleCloudPlatform/buildpack-samples)  
* [google buildpacks](https://github.com/GoogleCloudPlatform/buildpacks)  
* [google entrypoint](https://github.com/GoogleCloudPlatform/buildpacks#default-entrypoint-behavior)  
