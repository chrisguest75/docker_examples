# README

Demonstrate using the Python Docker SDK.  

NOTES:

* Docker SDK only supports old docker client, it does not support buildkit.  
* Docker on Whales interacts with the cmdline docker directly.  
* Both packages can be installed side-by-side to cover the both scenarios.  

Demonstrates:

* Building and running both bulidkit and Dockerfile.v0 builds  
* Tests running containers using requests and log scraping.  
* Test copying files into containers.  

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
pipenv run start:buildx

# run tests
pipenv run test
# filtering
pipenv run test -k test_buildx 
```

## Created

```sh
# add lint to dev dependencies
pipenv install --dev flake8  
```

## Resources

* Dash example [here](https://github.com/chrisguest75/mongo_examples/tree/main/06_dash)  
* Docker SDK for Python [here](https://docker-py.readthedocs.io/en/stable/)  
* docker-py Support BuildKit #2230 [here](https://github.com/docker/docker-py/issues/2230)  
* gabrieldemarmiesse/python-on-whales repo [here](https://github.com/gabrieldemarmiesse/python-on-whales)  
* Python on whales documentation [here](https://gabrieldemarmiesse.github.io/python-on-whales/)  
