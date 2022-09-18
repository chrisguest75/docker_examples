# SKAFFOLD

Demonstrate how to use `skaffold` for local development.  
  
Based on [kind_examples/08_skaffold](https://github.com/chrisguest75/kind_examples/tree/master/08_skaffold)  

NOTE: `docker compose` is not supported  
NOTE: There seems to be an issue with the docker deployer where it will pick a new port each time.  

TODO:

* Work out how volume shares are done.
* Passing environment variables in.

## Install

Ensure that skaffold is installed  

```sh
brew install skaffold
```

Once you have `skaffold` running you can go and make edits and see the rebuild and deploy.  

## Shellscript

Build a simple shell script container continuously.

### Shellscript - Build and Test Locally

Build and test the image

```sh
cd ./shellscript

# build the image manually
docker build -f ./Dockerfile -t skaffoldtest .

# run the image to test it
docker run -it --rm --name skaffoldtest skaffoldtest 
```

### Shellscript - Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```

## NGINX

Build a simple nginx container continuously.

### NGINX - Build and Test Locally

Build and test the image.

```sh
cd ./nginx

# build the image manually
docker build -f ./Dockerfile -t skaffoldtest .

# run the image to test it
docker run -it -p 8080:80 --rm --name skaffoldtest skaffoldtest 

open http://0.0.0.0:8080
```

### NGINX - Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```


## 👀 Resources

* [skaffold.dev](https://skaffold.dev/)  
* Working with [local-cluster](https://skaffold.dev/docs/environment/local-cluster/)  
* skaffold.yaml [here](https://skaffold.dev/docs/references/yaml/)  


https://github.com/GoogleContainerTools/skaffold/blob/995742df68c1725c9800b18c18d16f5a3fd6ffe3/pkg/skaffold/deploy/docker/deploy.go#L291-L314
