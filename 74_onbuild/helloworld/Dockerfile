FROM gcc-onbuild AS BUILDER

ARG MAKE_TARGET=all
ARG MAKE_OPTIONS=-B

WORKDIR /scratch

RUN ls -l
RUN /bin/bash -c "echo 10" | ./helloworld 

