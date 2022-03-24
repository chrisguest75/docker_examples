# syntax=docker/dockerfile:1.2

FROM ubuntu:21.04

RUN apt update && apt-get install -y git openssh-client

WORKDIR /scratch

RUN --mount=type=ssh git clone git@github.com:chrisguest75/docker_build_examples.git

#RUN git clone git@github.com:chrisguest75/docker_build_examples.git
