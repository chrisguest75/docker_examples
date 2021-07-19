FROM ubuntu:20.04

RUN apt-get update && apt-get install -y bash

WORKDIR /scratch
COPY hold.sh .

CMD [ "/bin/bash", "-c", "/scratch/hold.sh" ]
