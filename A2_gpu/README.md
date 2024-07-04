# GPU

Demonstrates some techniques for working with GPUs with Docker.  

## 📋 Script to follow

When run on a different system it shows the kernel version will be different. Shows the kernel version during build.  

## Checks

```sh
docker pull nvidia/cuda:12.5.0-runtime-ubuntu22.04

docker run -it --entrypoint /bin/bash docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04 
```

## 🏠 Build

Building will output version

```sh
# building can output the current kernel version
docker build --progress=plain -f Dockerfile.details -t a2_gpu .
```

> \> Linux 83fe3d9188f8 4.15.0-55-generic #60-Ubuntu SMP Tue Jul 2 18:22:20 UTC 2019 x86_64 Linux

## ⚡️ Execute (different machine)

Running on a **different machine (vm)** will return different value.

```sh
# Execution
docker run a2_gpu

# step in
docker run -it --entrypoint /bin/bash a2_gpu

docker run -it --entrypoint /bin/bash a2_gpu
```

## 👀 Resources

- File list of package cpuinfo in sid of architecture amd64 [here](https://packages.debian.org/sid/amd64/cpuinfo/filelist)
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/docker-specialized.html

https://github.com/NVIDIA/nvidia-container-toolkit
https://hub.docker.com/u/nvidia