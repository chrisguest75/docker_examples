  
FROM node:10.24.1 AS build-env
WORKDIR /scratch
COPY package-lock.json package.json ./
COPY index.js . 
RUN npm install && npm cache clean --force

FROM gcr.io/distroless/nodejs:10
COPY --from=build-env /scratch /scratch
WORKDIR /scratch
CMD ["index.js"]

