# syntax=docker/dockerfile:1.4
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

# # NOTE: Escape the \$ otherwise they are rendered at buildtime
# COPY <<EOF /scratch/exportldd.sh
# #!/usr/bin/env bash
# ldd "/scratch/out/bin/sox" >  /scratch/libs.txt
# cat /scratch/libs.txt | awk 'NF == 4 { {print \$3} }' > /scratch/libs_extracted.txt    
# cat /scratch/libs_extracted.txt | awk -F/ -vOFS=/ '{ print \$1,\$2,\$3,\$4; }' | sort -u > /scratch/libs_paths.txt
# tar -cvf /scratch/libraries.tar -T /scratch/libs_paths.txt
# mkdir -p /output/libs /output/bin
# tar xf /scratch/libraries.tar --directory=/output/libs
# cp "/scratch/out/bin/sox" /output/bin
# EOF
# RUN chmod +x /scratch/exportldd.sh && /scratch/exportldd.sh
# CMD ["./output/bin/sox", "--version"]


FROM ubuntu:20.04 AS PRODUCTION

COPY --from=BUILDER /scratch/out /usr
COPY --from=BUILDER /lib /lib 
COPY --from=BUILDER /lib64 /lib64 

CMD ["/usr/bin/sox"]


# # FROM scratch AS PRODUCTION
# FROM ubuntu:20.04 AS PRODUCTION

# COPY --from=BUILDER /output/bin/sox /usr/bin/sox
# COPY --from=BUILDER /output/libs/scratch/out /scratch/out

# ENTRYPOINT [ "/usr/bin/sox" ]
# CMD ["/usr/bin/sox", "--version"]