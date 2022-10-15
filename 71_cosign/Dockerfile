FROM ubuntu:20.04 as BASE

WORKDIR /scratch
COPY ./show_architecture.sh ./show_architecture.sh
ENTRYPOINT ["/bin/bash", "-c", "/scratch/show_architecture.sh"]

