FROM ubuntu:20.04 as BASE

ENV WORKERS=1
ENV TIMEOUT=10

RUN apt-get update && apt-get install -y \ 
        stress-ng \
        stress  \
        cgroup-tools \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /scratch
COPY ./show_architecture.sh ./show_architecture.sh
ENTRYPOINT ["/bin/bash", "-c", "/scratch/show_architecture.sh"]

