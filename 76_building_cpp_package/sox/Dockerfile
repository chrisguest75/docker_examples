FROM ubuntu:20.04 AS BUILDER

ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get install zsh curl git nano locales -y 
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

WORKDIR /scratch
#COPY sox-14.4.2 sox-14.4.2 
ADD ./sox-14.4.2.tar.gz ./
RUN buildDeps="autoconf \
                automake \
                cmake \
                curl \
                bzip2 \
                libexpat1-dev \
                g++ \
                gcc \
                git \
                gperf \
                libtool \
                make \
                meson \
                nasm \
                perl \
                pkg-config \
                python \
                libssl-dev \
                yasm \
                zlib1g-dev" && \
        apt-get -yqq update && \
        apt-get install -yq --no-install-recommends ${buildDeps}

WORKDIR sox-14.4.2
RUN ./configure --prefix=/scratch/out
RUN make -s && make install

RUN /scratch/out/bin/sox || true

RUN ls -laR /scratch/out

#FROM scratch AS PRODUCTION
FROM ubuntu:20.04 AS PRODUCTION

COPY --from=BUILDER /scratch/out /usr
# THIS NEEDS TO BE FILTERED
# root@1da61e4b533c:/scratch/out/bin# ldd sox
#         linux-vdso.so.1 (0x00007fffe8df2000)
#         libsox.so.3 => /scratch/out/lib/libsox.so.3 (0x00007f329d77f000)
#         libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f329d62c000)
#         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f329d609000)
#         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f329d417000)
#         libgomp.so.1 => /lib/x86_64-linux-gnu/libgomp.so.1 (0x00007f329d3d5000)
#         /lib64/ld-linux-x86-64.so.2 (0x00007f329d821000)
#         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f329d3cf000)
COPY --from=BUILDER /lib /lib 
COPY --from=BUILDER /lib64 /lib64 

CMD ["/usr/bin/sox"]