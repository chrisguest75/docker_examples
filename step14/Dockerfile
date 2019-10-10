FROM ubuntu:18.04

RUN apt update
RUN apt install stress-ng stress -y 
COPY hogger.sh /scripts/hogger.sh

CMD ["/scripts/hogger.sh"]
