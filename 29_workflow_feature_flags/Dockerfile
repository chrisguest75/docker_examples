FROM alpine:3.11.5 as test
RUN apk -v --no-cache --update \
      add \
      bash \
      git \
      bats \
      shellcheck

COPY process /usr/bin/process
COPY legal_branch_name /usr/bin/legal_branch_name

WORKDIR /test
COPY test test
COPY run_tests.sh run_tests.sh
COPY process legal_branch_name ./

RUN git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
RUN git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  

# run tests during build
RUN ./run_tests.sh

ENTRYPOINT [ "/usr/bin/process" ]