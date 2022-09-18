# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
ARG AWS_PROFILE=myprofile
ARG AWS_REGION=us-east-1
ENV AWS_PROFILE=${AWS_PROFILE} 
ENV AWS_REGION=${AWS_REGION}

ENV LANG=en_US.UTF-8 
ENV LANGUAGE=en_US:en 
ENV LC_ALL=en_US.UTF-8  


RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates curl jq unzip locales \
    && apt-get clean 

RUN locale-gen en_US.UTF-8 

RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
RUN unzip -q awscliv2.zip
RUN aws/install
RUN /usr/local/bin/aws --version

ENTRYPOINT ["/usr/local/bin/aws", "s3", "ls"]

FROM base AS withprofile
COPY --from=profile . /root/.aws

ENTRYPOINT ["/usr/local/bin/aws", "s3", "ls"]