FROM ubuntu:16.04 as base
#FROM bash:5.0.7 as base

#FROM scratch
RUN apt-get update && apt-get -y install ca-certificates
#FROM alpine
ARG microscannertoken
#RUN apt install --no-cache ca-certificates && update-ca-certificates
ADD https://get.aquasec.com/microscanner .
RUN chmod +x microscanner
#RUN ./microscanner $microscannertoken
ENTRYPOINT ["./microscanner"]
