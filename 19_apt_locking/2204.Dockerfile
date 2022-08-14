FROM ubuntu:22.04

#ARG CURL_VERSION=7.47.0-1ubuntu2.14
ARG CURL_VERSION=7.81.0-1ubuntu1.3 

RUN apt-get update && apt-cache madison curl \
        && apt-get --no-install-recommends install curl=${CURL_VERSION} -y \ 
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN apt-cache madison bash curl

RUN apt list --installed bash curl -a

CMD ["curl", "--version"]
