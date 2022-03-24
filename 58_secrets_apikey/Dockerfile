# syntax=docker/dockerfile:1.2
FROM ubuntu:21.04 AS STAGE1

WORKDIR /scratch

RUN --mount=type=secret,id=secretkey cat /run/secrets/secretkey

# DO NOT DO THIS (IT ADDS IT TO THE IMAGE)
RUN --mount=type=secret,id=secretkey cp /run/secrets/secretkey .

CMD ["/bin/bash", "ls /run/secrets/secretkey"]

FROM ubuntu:21.04 AS STAGE2

RUN cat /run/secrets/secretkey

