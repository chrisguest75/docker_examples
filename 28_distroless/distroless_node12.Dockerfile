FROM ubuntu:18.04

RUN apt-get update && apt-get install curl gnupg gnupg2 python3 python2.7 -y 

RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

RUN apt-get update && apt-get install git bazel -y

RUN ln -s /usr/bin/python2.7 /usr/bin/python
# RUN bazel run //experimental/nodejs

RUN apt install apt-transport-https ca-certificates curl software-properties-common -y 
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt-get update && apt-get install docker-ce -y

WORKDIR /scratch
RUN git clone https://github.com/GoogleContainerTools/distroless.git
WORKDIR /scratch/distroless

ENTRYPOINT ["/bin/bash"]
CMD ["bazel", "run", "//experimental/nodejs", "--verbose_failures", "--sandbox_debug"] 
