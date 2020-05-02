FROM ubuntu:16.04

ENV COMMITID=

RUN apt update && apt-cache madison curl && apt install curl -y

RUN apt-cache madison bash curl

RUN apt list --installed bash curl -a

WORKDIR /work
COPY .env .

CMD ["curl", "www.google.com"]
 