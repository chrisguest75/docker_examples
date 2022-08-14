# SKAFFOLD

Demonstrate how to use `skaffold` for local development.  
  
Based on [kind_examples/08_skaffold](https://github.com/chrisguest75/kind_examples/tree/master/08_skaffold)  

## Install

Ensure that skaffold is installed  

```sh
brew install skaffold
```

## Build and Test Locally

Build and test the image

```sh
# build the image manually
docker build -f ./shellscript/Dockerfile -t skaffoldtest ./shellscript

# run the image to test it
docker run -it --rm --name skaffoldtest skaffoldtest 
```

## Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```

Once you have `skaffold` running you can go and make edits and see the rebuild and deploy.  

## Resources

* [skaffold.dev](https://skaffold.dev/)  
* Working with [local-cluster](https://skaffold.dev/docs/environment/local-cluster/)  
* skaffold.yaml [here](https://skaffold.dev/docs/references/yaml/)  
