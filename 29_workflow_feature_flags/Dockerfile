FROM alpine:3.11.5
RUN apk update && apk add bash
COPY process /usr/bin/process

ENTRYPOINT [ "/usr/bin/process" ]