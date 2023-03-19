# README

Demonstrates building bash 5 on an ubuntu image.  

## 🏠 Build

```sh
docker build -f Dockerfile -t build_bash . 
```

## 🧪 Test

```sh
docker run -it --entrypoint /bin/bash build_bash  
docker run -it build_bash /bin/bash --version  
```
