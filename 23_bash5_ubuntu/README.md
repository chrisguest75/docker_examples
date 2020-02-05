# README.md
Demonstrates building bash 5 on an ubuntu image. 

## TODO


```
docker build -f Dockerfile -t build_bash . 
```

```
docker run -it --entrypoint /bin/bash build_bash  
docker run -it build_bash /bin/bash --version  
```