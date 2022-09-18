# NGINX

Build a simple nginx container continuously.  

## NGINX - Build and Test Locally

Build and test the image.

```sh
cd ./nginx

# build the image manually
docker build -f ./Dockerfile -t skaffoldtest .

# run the image to test it
docker run -it -p 8080:80 --rm --name skaffoldtest skaffoldtest 

open http://0.0.0.0:8080
```

## NGINX - Skaffold

```sh
# Create a deployment then call init
skaffold init        
```

```sh
# run skaffold
skaffold dev 
```
