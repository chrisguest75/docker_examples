# GPU

Demonstrates some techniques for working with GPUs with Docker.  

Ref: [shell_examples/81_gpu](https://github.com/chrisguest75/shell_examples/tree/master/81_gpu)  

NOTES:

- Docker is shifting to CDI for sharing in devices like GPU. Looks like this could extend to USB and FPGA in the future.  

## Contents

- [GPU](#gpu)
  - [Contents](#contents)
  - [📋 Script to follow](#-script-to-follow)
  - [Checks](#checks)
  - [🏠 Build](#-build)
  - [⚡️ Execute (different machine)](#️-execute-different-machine)
  - [Compiling with NVCC](#compiling-with-nvcc)
  - [👀 Resources](#-resources)

NOTES:

- `--gpus all` only works on docker desktop. Linux docker uses CDI (Container Device Interface).  
- `justfile` is setup for NixOS CDI.  

## 📋 Script to follow

When run on a different system it shows the kernel version will be different. Shows the kernel version during build.  

## Checks

Use `just sanity` or the following.  

```sh
# You may see this if no gpu is shared in.  
# 
# WARNING: The NVIDIA Driver was not detected.  GPU functionality will not be available.
docker pull nvidia/cuda:12.5.0-runtime-ubuntu22.04

docker run --gpus all docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04 

# nixos
docker run --device=nvidia.com/gpu=all docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04  

# enter the container
docker run -it --gpus all --entrypoint /bin/bash docker.io/nvidia/cuda:12.5.0-runtime-ubuntu22.04 
> nvidia-smi
```

## 🏠 Build

Use `just details` or the following.  

Building will output versions of nvidia and cuda.  

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

Use `just cuda` or the following.  

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
- nvidia container toolkit does not work on Docker but works in Podman [here](https://github.com/NixOS/nixpkgs/issues/337873)
- Compose Spec Site [here](https://www.compose-spec.io/)
- Using docker-compose and cdi to passthrough gpu to container via podman [here](https://github.com/NVIDIA/nvidia-container-toolkit/issues/126)
- docker-compose: Passing gpu with driver: cdi is not supported [here](https://github.com/containers/podman/issues/19338)
