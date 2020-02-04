FROM ubuntu:16.04
RUN apt update && apt install curl=7.47.0-1ubuntu2.14 -y

RUN apt-cache madison bash curl

RUN apt list --installed bash curl -a
