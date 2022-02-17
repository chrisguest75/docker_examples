# README

Demonstrate how to get `pyenv` installing a particular version in a container

## Setting up with pipenv and pyenv

```sh
export PIPENV_VENV_IN_PROJECT=1
pyenv install --list
pyenv install 3.9.7
pyenv local 3.9.7

# or use pipenv to create virtual env.  
pipenv install --python $(pyenv which python)        

#pipenv --rm
# switching into venv 
pipenv shell
# or
source ./.venv/bin/activate
```

## Build

```sh
# build
docker build --no-cache -t pyenvpy .

# run
docker run -d --name pyenvpy --rm pyenvpy   

# debug
docker run -it --rm --name pyenvpy --entrypoint "/bin/bash" pyenvpy

docker run --rm -d --name pyenvpy --entrypoint "/bin/bash" --rm pyenvpy -c 'sleep 10000'
docker exec -u root -it pyenvpy /bin/bash   
docker stop pyenvpy   
```

## Resources 

https://realpython.com/python-requests/