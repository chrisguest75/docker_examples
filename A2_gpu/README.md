# GPU

Demonstrates some techniques for working with GPUs with Docker.  

Ref: [shell_examples/81_gpu](https://github.com/chrisguest75/shell_examples/tree/master/81_gpu)  

## Contents

- [GPU](#gpu)
  - [Contents](#contents)
  - [📋 Script to follow](#-script-to-follow)
  - [Checks](#checks)
  - [🏠 Build](#-build)
  - [⚡️ Execute (different machine)](#️-execute-different-machine)
  - [Compiling with NVCC](#compiling-with-nvcc)
  - [👀 Resources](#-resources)

## 📋 Script to follow

When run on a different system it shows the kernel version will be different. Shows the kernel version during build.  

## Checks

```sh
docker pull nvidia/cuda:12.5.0-runtime-ubuntu22.04

docker run --gpus all docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04 

# enter the container
docker run -it --gpus all --entrypoint /bin/bash docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04 
> nvidia-smi
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

# share in gpu
docker run --gpus all a2_gpu

docker run --gpus all -it --entrypoint /bin/bash a2_gpu
```

## Compiling with NVCC

```sh
docker build --progress=plain -f Dockerfile.nvcc -t a2_gpu_nvcc .
# share in gpu
docker run --gpus all a2_gpu_nvcc

# jump into container
docker run -it --gpus all --entrypoint /bin/bash a2_gpu_nvcc
```

## 👀 Resources

- File list of package cpuinfo in sid of architecture amd64 [here](https://packages.debian.org/sid/amd64/cpuinfo/filelist)
- Installing the NVIDIA Container Toolkit [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt)
- NVIDIA CONTAINER TOOLKIT OVERVIEW [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)
- Specialized Configurations with Docker [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/docker-specialized.html)
- NVIDIA/nvidia-container-toolkit repo [here](https://github.com/NVIDIA/nvidia-container-toolkit)
- NVIDIA Corporation Dockerhub [here](https://hub.docker.com/u/nvidia)
- CUDA on WSL User Guide [here](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)
- NVIDIA CUDA Installation Guide for Linux [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#)
