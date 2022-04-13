ARG baseimage=ubuntu:latest
FROM $baseimage
# MAINTAINER name (deprecated)
LABEL org.opencontainers.image.authors="me"
# NOTE: This does not work - the variable seems empty.
LABEL dockerfile.baseimage=$baseimage 
LABEL dockerfile.description="Testing labels"

RUN echo "Image:${baseimage}"
ARG message
RUN echo "Message:${message}"

RUN apt-get update \
        && apt-get --no-install-recommends install curl -y \ 
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ./* ./

CMD ["curl", "www.google.com"]
 