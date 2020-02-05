FROM ubuntu:18.04

RUN apt-get update && apt-get install perl libncurses-dev unzip bc g++ rsync cpio make wget gcc file apt-utils patch -y

WORKDIR /scratch
COPY build_root.sh .

RUN wget https://buildroot.org/downloads/buildroot-2019.11.1.tar.gz
RUN tar -xvf buildroot-2019.11.1.tar.gz
WORKDIR /scratch/buildroot-2019.11.1
COPY .config .
RUN make

