FROM ubuntu:18.04

# add a user that matches the container you are investigating
ARG USERID=1001
ARG GROUPID=1001
RUN addgroup --system --gid $GROUPID nodeuser
RUN adduser --system --uid $USERID --gid $GROUPID nodeuser

RUN apt-get update && apt-get install htop --no-install-recommends -y 
RUN apt install lsof strace nano tcpdump dnsutils iproute2 apt-file -y
RUN apt-file update
