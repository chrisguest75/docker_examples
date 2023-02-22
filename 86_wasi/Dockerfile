FROM node:18.13.0-bullseye AS BUILDER
LABEL dockerfile.baseimage="node:18.13.0-bullseye" dockerfile.description="86_wasi" dockerfile.stage="BUILDER"

WORKDIR /scratch
COPY package.json package-lock.json ./
# https://docs.npmjs.com/cli/v7/commands/npm-ci
RUN npm ci

COPY asconfig.json ./
COPY assembly ./assembly
RUN npm run asbuild:debug -- --use abort=assembly/index/myAbort

FROM scratch AS PRODUCTION
LABEL dockerfile.baseimage="scratch" dockerfile.description="86_wasi" dockerfile.stage="PRODUCTION"

COPY --from=BUILDER /scratch/build/debug.wasm /debug.wasm

ENTRYPOINT [ "/debug.wasm" ]


