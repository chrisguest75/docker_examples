FROM node:14.17.3 as prod

ARG USERID=1001
ARG GROUPID=1001
RUN addgroup --system --gid $GROUPID nodeuser
RUN adduser --system --uid $USERID --gid $GROUPID nodeuser

WORKDIR /scratch
COPY package.json package-lock.json ./
COPY app.js logger.js ./
COPY handlers handlers
COPY views views 
COPY routes routes 
COPY public public 
COPY bin bin

RUN npm ci --only=production
USER nodeuser
EXPOSE 3000 
CMD [ "node", "./bin/www" ]

