FROM ubuntu:20.04 as BASE

RUN apt-get update && apt-get install -y \ 
        stress-ng \
        stress  \
        cgroup-tools \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

COPY hogger.sh /scripts/hogger.sh

CMD ["/scripts/hogger.sh"]
