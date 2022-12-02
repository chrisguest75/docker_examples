# syntax=docker/dockerfile:1.4
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates curl \
    && apt-get clean 

COPY --chmod=755 <<EOF /bin/ping.sh
#!/usr/bin/env bash
while true; do 
    curl -L --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -v http://www.google.com
    sleep 3;
done
EOF

CMD ["/bin/ping.sh"]

