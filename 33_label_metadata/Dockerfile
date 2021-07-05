FROM ubuntu:16.04
# MAINTAINER name (deprecated)
LABEL org.opencontainers.image.authors="me"
LABEL dockerfile.baseimage="ubuntu:16.04" dockerfile.description="Testing labels"

RUN apt-get update \
        && apt-get --no-install-recommends install curl -y \ 
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ./* ./

CMD ["curl", "www.google.com"]
 