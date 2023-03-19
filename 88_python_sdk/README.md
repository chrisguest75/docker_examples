# README

Demonstrate using the Python Docker SDK.  

NOTES:

* Docker SDK only supports old docker client, it does not support buildkit.  

TODO:

* Currently it is not working with buildkit.  
* Start an nginx container and copy files into it.  
* Template files  
* Make some requests and check the logs.  

## Install

```sh
export PIPENV_VENV_IN_PROJECT=1
pipenv install
pipenv install docker

pipenv shell
code . 
```

## Run

Uses pipenv scripts.  

```sh
# lint code
pipenv run lint

# run different examples
pipenv run start:nginx
pipenv run start:filecopy

# run tests
pipenv run test
```

## Created

```sh
# add lint to dev dependencies
pipenv install --dev flake8  
```

## Resources

* Dash example [here](https://github.com/chrisguest75/mongo_examples/tree/main/06_dash)  
* Docker SDK for Python [here](https://docker-py.readthedocs.io/en/stable/)  
https://github.com/gabrieldemarmiesse/python-on-whales
https://github.com/docker/docker-py/issues/2230
