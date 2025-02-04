# README

Demonstrates building a root image.  

📝 TODO:

* Make it version agnostic
* Look into jails

## 🏠 Build rootfs.tar

```sh
# get and depack code
just docker-build root

# start 
just docker-shell root

# build config
make menuconfig
# build the rootfs
make
```

## 🏠 Build image from rootfs

Use the rootfs in a container.  

```sh
# extract config and rootfs
id=[get docker container id]
just docker-extract $id

# import rootfs as a docker image
docker rmi myrootfs
docker import - myrootfs < ./rootfs.tar

# show image
dive myrootfs

# run new rootfs
docker run --rm -it --entrypoint /bin/sh myrootfs
```

## 🏠 Local test chroot (on linux)

Test the rootfs with chroot.  

```sh
TMP_FOLDER=./rootfs
# unpack
mkdir -p ${TMP_FOLDER}
tar xvf ./rootfs.tar -C ${TMP_FOLDER}
# start
pushd ${TMP_FOLDER}
# enter chroot
sudo chroot . /bin/sh
```

## 👀 Resources

* Buildroot [here](https://buildroot.org/)  
* buildroot.org/buildroot [repo](https://gitlab.com/buildroot.org/buildroot/)
* Installing the ncurses library in Debian/Ubuntu Linux [here](https://www.cyberciti.biz/faq/linux-install-ncurses-library-headers-on-debian-ubuntu-centos-fedora/)
* Chroot vs. Docker: A Comparison of Lightweight Virtualization Technologies [here](https://medium.com/@kabilanMahathevan/chroot-vs-docker-a-comparison-of-lightweight-virtualization-technologies-b9bd8a182d1c)
