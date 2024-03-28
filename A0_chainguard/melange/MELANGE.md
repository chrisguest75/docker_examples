# MELANGE

https://github.com/chainguard-dev/hello-wolfi-demo


```sh
git clone https://github.com/chainguard-dev/hello-wolfi-demo.git

 docker pull cgr.dev/chainguard/melange
 docker pull cgr.dev/chainguard/apko

 docker run --rm -v "${PWD}":/work cgr.dev/chainguard/melange keygen


docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-php.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub



docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-composer.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub

docker run --privileged --rm -v "${PWD}":/work -- \
  cgr.dev/chainguard/melange build melange-app.yaml \
  --arch x86_64 \
  --signing-key melange.rsa --keyring-append melange.rsa.pub

docker run --rm -v $(pwd):/work cgr.dev/chainguard/apko build /work/apko.yaml hello-wolfi:latest /work/hello-wolfi.tar -k /work/melange.rsa.pub


docker load < hello-wolfi.tar

 docker run --rm hello-wolfi:latest-amd64
```

## Resources

https://edu.chainguard.dev/open-source/wolfi/hello-wolfi/
