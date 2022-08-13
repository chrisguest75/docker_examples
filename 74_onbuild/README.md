# ONBUILD

Demonstrate using `ONBUILD` to control build steps.  

## Build gcc image

```sh
docker build -f ./gcc-onbuild/Dockerfile.gcc -t gcc-onbuild ./gcc-onbuild   
```

## Build app

```sh
docker build -f ./helloworld/Dockerfile -t helloworld ./helloworld   
```

## Troubleshooting

```sh
docker run --volume $(pwd)/helloworld:/scratch -it --entrypoint /bin/bash gcc-onbuild

# force rebuild
make -B
```

## Resources


https://stackoverflow.com/questions/28236870/error-undefined-reference-to-stdcout

https://stackoverflow.com/questions/1950926/create-directories-using-make-file

https://dockerlabs.collabnix.com/beginners/using-onbuild-images/#:~:text=The%20ONBUILD%20instruction%20adds%20to,instruction%20in%20the%20downstream%20Dockerfile.