# REGCTL



```sh
mkdir -p ./bins
curl -L https://github.com/regclient/regclient/releases/latest/download/regctl-linux-amd64 > ./bins/regctl
chmod +x ./bins/regctl
```

```sh
# doesn't work against dockerhub
./bins/regctl repo ls docker.io

./regctl image manifest docker.io/nginx:latest --platform linux/amd64


```

## Resources

https://github.com/regclient/regclient/blob/main/docs/regctl.md

