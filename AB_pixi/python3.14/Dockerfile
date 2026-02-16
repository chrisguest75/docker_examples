FROM ghcr.io/prefix-dev/pixi:latest AS build

WORKDIR /app
COPY . .
RUN pixi install --locked 
RUN pixi shell-hook -s bash > /shell-hook
RUN echo "#!/bin/bash" > /app/entrypoint.sh
RUN cat /shell-hook >> /app/entrypoint.sh
RUN echo 'exec "$@"' >> /app/entrypoint.sh

FROM ubuntu:24.04 AS production
WORKDIR /app
COPY --from=build /app/.pixi/envs/prod /app/.pixi/envs/prod
COPY --from=build --chmod=0755 /app/entrypoint.sh /app/entrypoint.sh
COPY ./main.py /app

EXPOSE 8000
ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "main.py" ]