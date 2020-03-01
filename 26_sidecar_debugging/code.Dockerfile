FROM node:12.16.1-stretch-slim

ARG USERID=1001
ARG GROUPID=1001
RUN addgroup --system --gid $GROUPID nodeuser
RUN adduser --system --uid $USERID --gid $GROUPID nodeuser

WORKDIR /scratch
COPY main.js main.js
USER nodeuser
CMD ["/usr/local/bin/node", "main.js"]
