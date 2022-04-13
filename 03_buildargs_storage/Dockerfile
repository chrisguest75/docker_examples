FROM bash:5.0.7 as bash

ARG mygithubcreds
RUN echo ${mygithubcreds}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

RUN echo "TARGETPLATFORM - platform of the build result. Eg linux/amd64, linux/arm/v7, windows/amd64." && \ 
    echo "TARGETOS - OS component of TARGETPLATFORM" && \ 
    echo "TARGETARCH - architecture component of TARGETPLATFORM" && \ 
    echo "TARGETVARIANT - variant component of TARGETPLATFORM" && \ 
    echo "BUILDPLATFORM - platform of the node performing the build." && \ 
    echo "BUILDOS - OS component of BUILDPLATFORM" && \ 
    echo "BUILDARCH - architecture component of BUILDPLATFORM" && \ 
    echo "BUILDVARIANT - variant component of BUILDPLATFORM" && \
    echo "TARGETPLATFORM=$TARGETPLATFORM" && \ 
    echo "TARGETOS=$TARGETOS" && \ 
    echo "TARGETARCH=$TARGETARCH" && \ 
    echo "TARGETVARIANT=$TARGETVARIANT" && \ 
    echo "BUILDPLATFORM=$BUILDPLATFORM" && \ 
    echo "BUILDOS=$BUILDOS" && \ 
    echo "BUILDARCH=$BUILDARCH" && \ 
    echo "BUILDVARIANT=$BUILDVARIANT" 


CMD ["bash", "-c", "env"]