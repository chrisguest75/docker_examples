# BUILDKIT OPEN TELEMETRY

TODO:

* Tracing a buildkit build.
* Use the x-develop watcher

## Start Collector

```sh
docker compose --env-file ./.env up -d --build --force-recreate collector 
docker compose logs collector
```

## Configure builder

```sh
docker buildx ls 
# create a second builder
docker buildx create --use --driver docker-container --driver-opt network=host --driver-opt image=moby/buildkit:v0.11.5 --driver-opt "env.JAEGER_TRACE=0.0.0.0:6831" --name oteltest --platform linux/amd64

docker buildx inspect --bootstrap

```

## Build

```sh
# docker buildx create --use \
#   --name mybuilder \
#   --driver docker-container \
#   --driver-opt "network=host" \
#   --driver-opt "env.JAEGER_TRACE=localhost:6831"

docker buildx build --no-cache --builder oteltest --platform linux/amd64 --load --progress=plain -f Dockerfile.processor -t processor-amd64 .
```

## Cleanup

```sh
docker compose --env-file ./.env down  
docker compose logs collector

docker buildx rm oteltest      
```

## Resources

* OpenTelemetry support [here](https://docs.docker.com/build/building/opentelemetry/)  
* Jaeger Receiver [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/receiver/jaegerreceiver/README.md)  
* Docker Stats Receiver [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/dockerstatsreceiver)  
* List of opentelemetry-collector-contrib receivers [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver)  

https://opentelemetry.io/docs/reference/specification/trace/sdk_exporters/jaeger/