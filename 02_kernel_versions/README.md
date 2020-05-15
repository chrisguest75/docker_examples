# Example 2 - Kernel versions
Demonstrates how kernel versions are different for build and execution.  

## Script to follow
Shows the kernel version during build.   
When run on a different system it shows the kernel version will be different. 

## Build
Building will output version
```sh
# building can output the current kernel version
docker build --no-cache -t $(basename $(pwd)) .

Linux 83fe3d9188f8 4.15.0-55-generic #60-Ubuntu SMP Tue Jul 2 18:22:20 UTC 2019 x86_64 Linux
```

## Execute (different machine)
Running on a **different machine (vm)** will return different value.
```sh
# Execution
docker run $(basename $(pwd))

Linux 3659e36111ba 4.9.184-linuxkit #1 SMP Tue Jul 2 22:58:16 UTC 2019 x86_64 Linux
```