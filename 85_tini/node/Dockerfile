FROM node:16.13.2-bullseye AS BUILDER
LABEL dockerfile.baseimage="node:16.13.2-bullseye" dockerfile.description="nodetini" dockerfile.stage="BUILDER"

WORKDIR /scratch
COPY package.json package-lock.json ./
# https://docs.npmjs.com/cli/v7/commands/npm-ci
RUN npm ci

COPY tsconfig.json .prettierrc jest.config.js .eslintrc ./
COPY public ./public
COPY routes ./routes
COPY src ./src
COPY tests ./tests
RUN npm run lint
RUN npm run test:coverage
RUN npm run build
RUN npm audit
RUN npm ci --only=production && npm cache clean --force

FROM gcr.io/distroless/nodejs:16 AS PRODUCTION
LABEL dockerfile.baseimage="gcr.io/distroless/nodejs:16" dockerfile.description="nodetini" dockerfile.stage="PRODUCTION"

ENV NODE_ENV production

WORKDIR /work
COPY --from=BUILDER /scratch/node_modules ./node_modules
COPY --from=BUILDER /scratch/build ./
COPY --from=BUILDER /scratch/public ./public

CMD ["/work/src/index.js"]