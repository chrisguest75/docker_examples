# syntax=docker/dockerfile:1.2

FROM ubuntu:21.04

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends git openssh-client \
    && apt-get clean 

WORKDIR /scratch
RUN --mount=type=ssh ssh-add -l

RUN --mount=type=ssh git clone git@github.com:chrisguest75/docker_build_examples.git

#RUN git clone git@github.com:chrisguest75/docker_build_examples.git
