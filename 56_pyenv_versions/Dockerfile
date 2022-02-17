FROM ubuntu:20.04

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y bash curl git nano locales apt-transport-https make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev xz-utils libxml2-dev libxmlsec1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8  

# libffi-dev liblzma-dev tk-dev 
# RUN apt-get install -y mecab-ipadic-utf8 

# pyenv
ARG USERID=1000
ARG GROUPID=1000
RUN addgroup --system --gid $GROUPID appuser
RUN adduser --system --uid $USERID --gid $GROUPID appuser

ENV HOME /home/appuser
WORKDIR $HOME
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

RUN mkdir /workbench

WORKDIR /workbench
COPY ./Pipfile /workbench/Pipfile
COPY ./Pipfile.lock /workbench/Pipfile.lock 
COPY [".python-version", "/workbench/.python-version"]
COPY ["./main.py", "/workbench/main.py"]

USER appuser

ENV PYENV_ROOT="$HOME/.pyenv" 
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install 3.9.7
RUN pyenv global 3.9.7

RUN pip3 install pipenv


RUN set -ex && pipenv install --deploy --system
RUN pipenv install --deploy --system --dev


# EXPOSE 8888
# CMD ["python", "main.py"]
