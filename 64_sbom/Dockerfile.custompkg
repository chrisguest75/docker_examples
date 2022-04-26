FROM ubuntu:16.04

RUN apt-get update && apt-get install bash build-essential -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /packages
COPY ./build.sh /usr/bin/build
#CMD ["build"]
ENTRYPOINT ["build"]

