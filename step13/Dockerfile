FROM ubuntu:18.04 as base

#### ROOT
USER root
RUN echo "whoami:$(whoami) - pwd:$(pwd)"
# this does not work
#RUN mkdir -p "myfile_$(whoami)"
#COPY test.txt "myfile_$(whoami)/test.txt"
RUN mkdir -p "myfile_root"
COPY test.txt "myfile_root/test.txt"

# workdir will create the directory.
WORKDIR /workdir_creates

WORKDIR /myfile_root
RUN echo "whoami:$(whoami) - pwd:$(pwd)"

ARG USERID=1000
ARG GROUPID=1000
RUN addgroup --system --gid $GROUPID mynewuser
RUN adduser --system --uid $USERID --gid $GROUPID mynewuser

#### NEW USER 
USER mynewuser
RUN echo "whoami:$(whoami) - pwd:$(pwd)"

WORKDIR /home/mynewuser

#RUN mkdir -p "myfile_$(whoami)"
#COPY test.txt "myfile_$(whoami)/test.txt"
RUN mkdir -p "myfile_mynewuser"
COPY test.txt "myfile_mynewuser/test.txt"
COPY --chown=mynewuser test.txt "myfile_mynewuser/chowned_test2.txt"

WORKDIR /home/mynewuser/myfile_mynewuser
RUN echo "whoami:$(whoami) - pwd:$(pwd)"

RUN touch "./touched_file.txt"

COPY test_permissions.sh "test_permissions.sh"
COPY --chown=mynewuser test_permissions.sh "chowned_test_permissions.sh"

