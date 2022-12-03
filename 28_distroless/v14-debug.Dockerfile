FROM node:14.17.1 AS build-env
WORKDIR /scratch
COPY package-lock.json package.json ./
COPY index.js . 
RUN npm install && npm cache clean --force

FROM gcr.io/distroless/nodejs14-debian11:debug
COPY --from=build-env /scratch /scratch
WORKDIR /scratch
CMD ["index.js"]
