# 06 - Multistage small image size

Demonstrate multistage build small image size using multistage

TODO:

1. Add the build targets --target
1. Caching?

## 📋 Script to follow

Demonstrate multistage build

```sh
# build the image 
docker build --no-cache -t docker_terraform .

# run terraform and print version
docker run -it docker_terraform version
```
