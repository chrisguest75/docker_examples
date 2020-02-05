FROM ubuntu:16.04

RUN apt-get update && apt-get install curl build-essential -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /scratch
RUN curl ftp://www.mirrorservice.org/sites/ftp.gnu.org/gnu/bash/bash-5.0.tar.gz -o bash-5.0.tar.gz

RUN tar xf bash-5.0.tar.gz
WORKDIR /scratch/bash-5.0
RUN ./configure
RUN make
RUN make install
