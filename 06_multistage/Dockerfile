FROM golang:1.12-alpine as base

ENV TERRAFORM_VERSION=0.11.14
RUN apk add --update git bash openssh
ENV TF_DEV=true
ENV TF_RELEASE=true
WORKDIR $GOPATH/src/github.com/hashicorp/terraform

RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

FROM scratch as final
COPY --from=base /go/bin/terraform /bin/terraform
COPY --from=base /tmp /tmp
ENTRYPOINT ["/bin/terraform"]
