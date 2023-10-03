# S6 Overlay

Demonstrate how to use s6 overlay.  

TODO:

* execlineb
* oneshot

## Reason

S6 Overlay offers a way of controlling the pid1 process.  

```sh
# build
docker build -f Dockerfile -t s6overlay .

# run 
docker run --name s6overlay --rm -d -p 80:80 s6overlay
docker logs -f s6overlay

docker exec -it s6overlay /bin/bash
ps -ax

watch -n 1 docker top s6overlay acxf

curl --head http://127.0.0.1/

docker stop s6overlay
```

## Resources

* just-containers/s6-overlay repo [here](https://github.com/just-containers/s6-overlay)  
* How to understand S6 Overlay v3 [here](https://darkghosthunter.medium.com/how-to-understand-s6-overlay-v3-95c81c04f075)  
* s6 what is it? [here](https://skarnet.org/software/s6/index.html)
* Multiprocess Containers with S6 Overlay [here](https://www.tonysm.com/multiprocess-containers-with-s6-overlay/)
* Managing multi-process applications in containers using s6 [here](https://kreuzwerker.de/en/post/managing-multi-process-applications-in-containers-using-s6)