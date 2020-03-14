  
FROM node:10.17.0 AS build-env
WORKDIR /scratch
COPY package-lock.json package.json ./
COPY index.js . 
RUN npm install && npm cache clean --force

FROM gcr.io/distroless/nodejs
COPY --from=build-env /scratch /scratch
WORKDIR /scratch
CMD ["index.js"]

