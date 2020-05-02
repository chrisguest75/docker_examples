FROM ubuntu:16.04

RUN apt-get update \
        && apt-get --no-install-recommends install curl -y \ 
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ./* ./

CMD ["curl", "www.google.com"]
 