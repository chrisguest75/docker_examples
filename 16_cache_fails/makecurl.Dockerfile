FROM ubuntu:latest as base
RUN apt update && apt install make curl -y

RUN echo "Hello"

WORKDIR /scratch
RUN curl -s -o london.txt "http://worldtimeapi.org/api/timezone/Europe/London.txt"
RUN cat london.txt

CMD ["/bin/cat", "/scratch/london.txt"]

