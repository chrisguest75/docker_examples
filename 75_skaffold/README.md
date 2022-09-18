# SKAFFOLD

Demonstrate how to use `skaffold` for local development.  
  
Based on [kind_examples/08_skaffold](https://github.com/chrisguest75/kind_examples/tree/master/08_skaffold)  

NOTE: `docker compose` is not supported  
NOTE: There seems to be an issue with the docker deployer where it will pick a new port each time.  

TODO:

* Work out how volume shares are done.
* Passing environment variables in.

## Install

Ensure that skaffold is installed  

```sh
brew install skaffold
```

Once you have `skaffold` running you can go and make edits and see the rebuild and deploy.  

## Shellscript

[A shellscript example here](./shellscript/README.md) is most basic example.  

## NGINX

[An NGINX example here](./nginx/README.md) shows how to use ports.  

## AWSCLI

[An awscli example here](./awscli/README.md) shows how to use fake sharing in a volume with multiple contexts and using hardcoded ENVs from build args.  

## 👀 Resources

* [skaffold.dev](https://skaffold.dev/)  
* Working with [local-cluster](https://skaffold.dev/docs/environment/local-cluster/)  
* skaffold.yaml [here](https://skaffold.dev/docs/references/yaml/)  
* Docker Deploy code [here](https://github.com/GoogleContainerTools/skaffold/blob/995742df68c1725c9800b18c18d16f5a3fd6ffe3/pkg/skaffold/deploy/docker/deploy.go#L291-L314)  
