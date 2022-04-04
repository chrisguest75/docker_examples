# syntax=docker/dockerfile:1.4
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates curl \
    && apt-get clean 

COPY <<EOF /bin/timeout.sh
#!/usr/bin/env bash
LOOPCOUNT=\${1:-10} 
if [ -z "\${LOOPCOUNT}" ];then 
    LOOPCOUNT=10 
fi
echo "LOOPCOUNT=\$LOOPCOUNT"    
for index in $(seq 0 \$LOOPCOUNT ); 
do 
    echo "."
    sleep 1;
done
EOF

RUN chmod +x /bin/timeout.sh
ENTRYPOINT ["/bin/timeout.sh"]
CMD ["/bin/timeout.sh"]