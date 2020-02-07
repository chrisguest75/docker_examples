FROM ubuntu:16.04 as base

RUN apt-get update && apt-get install netcat -y

WORKDIR /webserver
COPY stupid_webserver.sh .
COPY server_logic.sh .
CMD ["/webserver/stupid_webserver.sh"]
