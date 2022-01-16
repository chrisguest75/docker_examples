FROM ubuntu:20.04

RUN apt-get update && apt-get install apt-transport-https git curl wget locales -y 

RUN locale-gen en_US.UTF-8  

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev xz-utils libxml2-dev libxmlsec1-dev 

# \
#         && apt-get clean \
#         && rm -rf /var/lib/apt/lists/*
# libffi-dev liblzma-dev tk-dev 
#  

# RUN apt-get install -y mecab-ipadic-utf8 

# # pyenv
# ARG USERID=1000
# ARG GROUPID=1000
# RUN addgroup --system --gid $GROUPID appuser
# RUN adduser --system --uid $USERID --gid $GROUPID appuser

# ENV HOME /home/appuser
# WORKDIR $HOME
# RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

# ENV PYENV_ROOT="$HOME/.pyenv" 
# ENV PATH="$PYENV_ROOT/bin:$PATH"
# RUN pyenv install 3.9.7
# RUN pyenv global 3.9.7
# RUN pip install pipenv

# RUN mkdir /workbench

# WORKDIR /workbench
# COPY ./Pipfile /workbench/Pipfile
# COPY ./Pipfile.lock /workbench/Pipfile.lock 

# #RUN set -ex && pipenv install --deploy --system
# RUN pipenv install --deploy --system --dev

# COPY ["./.python-version", "./.python-version"]
# COPY ["./main.py", "./main.py"]

# USER appuser
# EXPOSE 8888
# CMD ["python", "main.py"]
