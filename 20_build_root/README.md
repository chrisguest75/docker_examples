# README

Demonstrates building a root image.  

📝 TODO:

* Make it version agnostic

## 🏠 Build rootfs.tar

```sh
docker build -t full_build_root -f build.Dockerfile .  
```

## 🏠 Build image from rootfs

```sh
id=$(docker create full_build_root)
docker cp $id:/scratch/buildroot-2019.11.1/output/images/rootfs.tar .
docker rm -v $id
docker import - myrootfs < ./output/images/rootfs.tar
docker run -it --entrypoint /bin/sh myrootfs
```

## 🏠 Local test chroot (on linux)

```sh
TMP_FOLDER=$(mktemp)
# unpack
mkdir -p ${TMP_FOLDER}
tar xvf ./rootfs.tar -C ${TMP_FOLDER}
# start
pushd ${TMP_FOLDER}
sudo chroot . /bin/sh
```

## 👀 Resources

* Buildroot [here](https://buildroot.org/)  
