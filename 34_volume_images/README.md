# README
Demonstrates how to configure an image that can be mounted as a volume into a container.  

## TODO
1. Demonstrate how it can be done
1. File permissions and group permissions
1. 

## Example
Docker volume mounting 
    docker create -v /cfg --name configs alpine:3.4 /bin/true
    docker cp path/in/your/source/code/app_config.yml configs:/cfg
    docker run --volumes-from configs app-image:1.2.3

```sh
docker create -v /cfg --name configs alpine:3.4 /bin/true
docker cp path/in/your/source/code/app_config.yml configs:/cfg
```