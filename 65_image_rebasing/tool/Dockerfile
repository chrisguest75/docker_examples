FROM node:16.13.2-bullseye AS BUILDER
LABEL dockerfile.baseimage="node:16.13.2-bullseye" dockerfile.description="tool" dockerfile.stage="BUILDER"

WORKDIR /scratch
COPY package.json package-lock.json ./
# https://docs.npmjs.com/cli/v7/commands/npm-ci
RUN npm ci

COPY tsconfig.json .prettierrc jest.config.js .eslintrc ./
COPY src ./src
COPY tests ./tests
#RUN npm run lint
#RUN npm run test:coverage
RUN npm run build
#RUN npm audit

FROM node:16.13.2-bullseye AS PRODUCTION
LABEL dockerfile.baseimage="node:16.13.2-bullseye" dockerfile.description="01_helloworld_typescript_opentelemetry" dockerfile.stage="PRODUCTION"

WORKDIR /work
COPY --from=BUILDER /scratch/node_modules ./node_modules
COPY --from=BUILDER /scratch/build ./

CMD ["/usr/local/bin/node", "/work/src/index.js"]