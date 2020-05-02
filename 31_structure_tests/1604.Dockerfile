FROM ubuntu:16.04
RUN apt update && apt-cache madison curl && apt install curl -y

RUN apt-cache madison bash curl

RUN apt list --installed bash curl -a

COPY .env /work/

CMD ["curl", "www.google.com"]
