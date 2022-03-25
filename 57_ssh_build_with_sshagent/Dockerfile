# syntax=docker/dockerfile:1.2

FROM ubuntu:21.04

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends git openssh-client \
    && apt-get clean 

WORKDIR /scratch

# show the ssh-agent keys are available
RUN --mount=type=ssh ssh-add -l
RUN --mount=type=ssh ssh-add -L

# add to known hosts 
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN cat ~/.ssh/known_hosts

# test connection
RUN --mount=type=ssh ssh -vvv github.com || true
RUN --mount=type=ssh ssh -T git@github.com || true

RUN --mount=type=ssh git clone git@github.com:chrisguest75/docker_build_examples.git

