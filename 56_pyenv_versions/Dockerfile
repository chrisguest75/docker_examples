FROM ubuntu:20.04

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y bash curl git nano locales apt-transport-https make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev xz-utils libxml2-dev libxmlsec1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8  

# pyenv
# ARG USERID=1000
# ARG GROUPID=1000
# RUN addgroup --system --gid $GROUPID appuser
# RUN adduser --system --uid $USERID --gid $GROUPID appuser

# ENV HOME /home/appuser
ENV HOME /home/root
WORKDIR $HOME
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

WORKDIR /workbench
COPY ./Pipfile /workbench/Pipfile
COPY ./Pipfile.lock /workbench/Pipfile.lock 
COPY ./.python-version /workbench/.python-version
COPY ["./main.py", "/workbench/main.py"]

#USER appuser

ENV PYENV_ROOT="$HOME/.pyenv" 
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install $(cat /workbench/.python-version)
RUN pyenv global $(cat /workbench/.python-version)

RUN pyenv exec pip3 install pipenv
RUN set -ex && pyenv exec pipenv install --deploy --system
RUN pyenv exec pipenv install --deploy --system --dev

CMD ["pyenv", "exec", "python", "main.py"]
