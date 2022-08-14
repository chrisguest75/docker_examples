# README

Building example CPP package (SOX) inside a docker container.  

INSTALL instructions [here](sox/sox-14.4.2/INSTALL)

TODO:

* Build and transfer to a scratch container

## Get code

Ref: [shell_examples/63_md5_file_id](https://github.com/chrisguest75/shell_examples/tree/master/63_md5_file_id)  

```sh
function verify_md5() {
    : ${1?"${FUNCNAME[0]}(url) - missing url argument"}
    : ${2?"${FUNCNAME[0]}(url) - missing md5 argument"}

    local URL=$1
    local MD5=$2
    local FILENAME="./$(basename $URL)"
    curl -s -o $FILENAME $URL 
    local FILE_MD5=$(cat $FILENAME | md5)
    if [[ $FILE_MD5 == $MD5 ]]; then
        echo "SUCCESS: MD5 for $FILENAME matches $MD5"
    else
        >&2 echo "FAIL: MD5 for $FILENAME does not match $MD5 - actual $FILE_MD5"
    fi 
}
[[ -d ./sox ]] && pushd ./sox 
MD5="d04fba2d9245e661f245de0577f48a33"
URL=https://nchc.dl.sourceforge.net/project/sox/sox/14.4.2/sox-14.4.2.tar.gz 
verify_md5 "$URL" "$MD5"
```

## Build sox

```sh
# build image with build tools (add --no-cache if reqd)
docker build --progress plain -f ./sox/Dockerfile --target PRODUCTION -t sox ./sox  

docker run --rm -it sox   
```

## Troubleshooting



### Scratch container

```sh
docker build --progress plain -f ./sox/Dockerfile --target BUILDER -t soxbuild ./sox 

docker run --rm -it --entrypoint /bin/bash soxbuild   

ldd ./sox


```

linux-vdso.so.1 - https://man7.org/linux/man-pages/man7/vdso.7.html

### Failing to build

```sh
# unpack source
tar -xvf ./sox-14.4.2.tar.gz 

# share in code - allows us to see changes. 
docker run --volume $(pwd)/sox-14.4.2:/scratch/sox-14.4.2 -it --entrypoint /bin/bash sox 

mkdir -p out
cd sox-14.4.2/

./configure --prefix=/scratch/out
make -s && make install

ls -la -R /scratch/out
# size of binaries
du -h /scratch/out
```

## Resources

* dockerhub vanb777/ffmpeg-sox [here](https://hub.docker.com/r/vanb777/ffmpeg-sox/dockerfile)  
* Understanding Shared Libraries in Linux [here](https://www.tecmint.com/understanding-shared-libraries-in-linux/#:~:text=By%20default%2C%20libraries%20are%20located,so.)  
* brianc118/sox_local_install gist [here](https://gist.github.com/brianc118/a71f6d41c4d105835f91d173f2f1cd5c)  

Where is linux-vdso.so.1 present on the file system https://stackoverflow.com/questions/58657036/where-is-linux-vdso-so-1-present-on-the-file-system

https://medium.com/@mfcollins3/shipping-c-programs-in-docker-1d79568f6f52

https://blog.conan.io/2021/08/09/Modern-docker-images.html

https://0xax.gitbooks.io/linux-insides/content/

https://0xax.gitbooks.io/linux-insides/content/SysCall/linux-syscall-4.html

