FROM ubuntu:24.10

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates curl \
    && apt-get clean 

# NOTE: Escape the \$ otherwise they are rendered at buildtime
COPY --chmod=755 <<EOF /bin/ping.sh
#!/usr/bin/env bash
URL=\${1:-https://google.com} 
if [ -z "\${URL}" ];then 
    URL=https://google.com
fi
echo "URL=\$URL"  
while true; do 
    curl -L --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -v \$URL
    sleep 5;
done
EOF

# NOTE: This is not required as there is an undocumented flag --chmod
# Support for non-octal is coming soon - https://github.com/moby/buildkit/issues/1951
#RUN chmod +x /bin/ping.sh

# Show that we can use heredocs to within heredocs
COPY --chmod=755 <<EOF /bin/heredoc.sh
# another heredoc 
cat <<- HEREDOC > /bin/subheredoc.sh
This is a test
HEREDOC

EOF

ENTRYPOINT ["/bin/ping.sh"]
CMD [""]

