# README
Demonstrates how to use container structure testing.

[Docs](https://github.com/GoogleContainerTools/container-structure-test)

## Prereqs
Install 
```sh
brew install container-structure-test       
```

## Examples

```sh
docker run -it --rm --entrypoint /bin/bash chrisguest/turn   
```

```sh
container-structure-test test --image chrisguest/turn --config test_turn.yaml
```
