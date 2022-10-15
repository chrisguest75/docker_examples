# syntax=docker/dockerfile:1.4
FROM ubuntu:20.04 AS prebuild

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
FROM prebuild AS builder
RUN ./configure --prefix=/scratch/out --with-pic --enable-static --disable-shared 
RUN make -s && make install

RUN /scratch/out/bin/sox || true

RUN ls -laR /scratch/out

# NOTE: Escape the \$ otherwise they are rendered at buildtime
COPY --chmod=755 <<EOF /scratch/exportldd.sh
#!/usr/bin/env bash
ldd "/scratch/out/bin/sox" >  /scratch/libs.txt
cat /scratch/libs.txt | awk 'NF == 4 { {print \$3} }' > /scratch/libs_extracted.txt    
cat /scratch/libs_extracted.txt | awk -F/ -vOFS=/ '{ print \$1,\$2,\$3,\$4; }' | sort -u > /scratch/libs_paths.txt
tar -cvf /scratch/libraries.tar --dereference -T /scratch/libs_paths.txt
mkdir -p /output/libs /output/bin
tar xf /scratch/libraries.tar --directory=/output/libs
cp "/scratch/out/bin/sox" /output/bin
mkdir -p /output/libs/lib64
cp /lib64/ld-linux-x86-64.so.2 /output/libs/lib64/ld-linux-x86-64.so.2
EOF
# NOTE: This is not required as there is an undocumented flag --chmod
# RUN chmod +x /scratch/exportldd.sh && /scratch/exportldd.sh
RUN /scratch/exportldd.sh

CMD ["./output/bin/sox", "--version"]


# FROM ubuntu:20.04 AS production

# COPY --from=builder /scratch/out /usr
# COPY --from=builder /lib /lib 
# COPY --from=builder /lib64 /lib64 

# CMD ["/usr/bin/sox"]


FROM scratch AS production
#FROM ubuntu:20.04 AS production

COPY --from=builder /output/bin/sox /usr/bin/sox
COPY --from=builder /output/libs/lib /lib
COPY --from=builder /output/libs/lib64 /lib64

ENTRYPOINT [ "/usr/bin/sox" ]
CMD ["/usr/bin/sox", "--version"]