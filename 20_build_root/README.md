# README.md
Demonstrates building a root image

## TODO
1. Make it version agnostic


## Build rootfs.tar
```
docker build -t full_build_root -f build.Dockerfile .  
```

## Build image from rootfs
```
id=$(docker create full_build_root)
docker cp $id:/scratch/buildroot-2019.11.1/output/images/rootfs.tar .
docker rm -v $id
docker import - myrootfs < ./output/images/rootfs.tar
docker run -it --entrypoint /bin/sh myrootfs
```

## Local test chroot (on linux)
```
TMP_FOLDER=$(mktemp)
mkdir -p ${TMP_FOLDER}
tar xvf ./rootfs.tar -C ${TMP_FOLDER}
pushd ${TMP_FOLDER}
sudo chroot . /bin/sh
```
