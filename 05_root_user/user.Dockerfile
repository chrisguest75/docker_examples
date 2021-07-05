FROM ubuntu:18.04

ARG USERID=1001
ARG GROUPID=1001
RUN addgroup --system --gid $GROUPID myuser
RUN adduser --system --uid $USERID --gid $GROUPID myuser

USER myuser
RUN uname -a 

CMD ["uname", "-a"]

