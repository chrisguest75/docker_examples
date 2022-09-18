# Shellscript

Build a simple shell script container continuously.  

## Shellscript - Build and Test Locally

Build and test the image

```sh
cd ./shellscript

# build the image manually
docker build -f ./Dockerfile -t skaffoldtest .

# run the image to test it
docker run -it --rm --name skaffoldtest skaffoldtest 
```

## Shellscript - Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```
