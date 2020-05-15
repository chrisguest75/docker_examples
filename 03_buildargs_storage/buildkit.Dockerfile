# syntax = docker/dockerfile:1.0-experimental
FROM bash:5.0.7 as bash

RUN echo "hello from buildkit"
# shows secret from default secret location
RUN --mount=type=secret,id=mysecret,dst=/tmp/mysecret.txt cat /tmp/mysecret.txt

CMD ["bash", "-c", "env"]