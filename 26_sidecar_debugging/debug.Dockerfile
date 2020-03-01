FROM ubuntu:18.04

RUN apt-get update && apt-get install htop --no-install-recommends -y && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

