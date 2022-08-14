# ONBUILD

Demonstrate using `ONBUILD` to control build steps.  
The example demonstrates using `gcc` build tools in base image to build an executable.  

## Build gcc image

This is the image containing the `ONBUILD` commands.  

```sh
docker build -f ./gcc-onbuild/Dockerfile.gcc -t gcc-onbuild ./gcc-onbuild   
```

## Build app

```sh
# pass in some options to force a build all
docker build --build-arg MAKE_OPTIONS=-B --build-arg MAKE_TARGET= --progress=plain -f ./helloworld/Dockerfile -t helloworld ./helloworld   
```

## Troubleshooting

To troubleshoot we share in the code in a volume.  

```sh
docker run --volume $(pwd)/helloworld:/scratch -it --entrypoint /bin/bash gcc-onbuild

# force rebuild
make -B
```

## Resources

* Using ONBUILD instruction [here](https://dockerlabs.collabnix.com/beginners/using-onbuild-images/#:~:text=The%20ONBUILD%20instruction%20adds%20to,instruction%20in%20the%20downstream%20Dockerfile.)  
* Error "undefined reference to 'std::cout'" [here](https://stackoverflow.com/questions/28236870/error-undefined-reference-to-stdcout)  
* Create directories using make file [here](
https://stackoverflow.com/questions/1950926/create-directories-using-make-file)  
* How does "make" app know default target to build if no target is specified? [here](https://stackoverflow.com/questions/2057689/how-does-make-app-know-default-target-to-build-if-no-target-is-specified)  
