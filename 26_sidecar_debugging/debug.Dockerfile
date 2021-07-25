FROM ubuntu:20.04

# add a user that matches the container you are investigating
ARG USERID=1001
ARG GROUPID=1001
RUN addgroup --system --gid $GROUPID nodeuser
RUN adduser --system --uid $USERID --gid $GROUPID nodeuser

RUN apt-get update && apt-get install htop --no-install-recommends -y 
RUN apt-get install curl lsof strace nano tcpdump iproute2 dnsutils -y
RUN apt-get install git nmap iputils-ping -y
RUN apt-get install apt-file --no-install-recommends -y
RUN apt-file update
