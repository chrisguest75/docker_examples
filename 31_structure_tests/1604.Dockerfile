FROM ubuntu:16.04

ENV COMMITID=

RUN apt update && apt-cache madison curl && apt install curl -y
        #&& apt-get clean \
        #&& rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ./* ./

CMD ["curl", "www.google.com"]
 