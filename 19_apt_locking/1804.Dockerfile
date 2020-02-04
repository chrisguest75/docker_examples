FROM ubuntu:18.04
RUN apt update && apt install curl=7.58.0-2ubuntu3.8 -y

RUN apt-cache madison bash curl

RUN apt list --installed bash curl -a