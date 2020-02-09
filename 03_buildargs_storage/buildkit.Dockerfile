FROM bash:5.0.7 as bash

# shows secret from default secret location
RUN --mount=type=secret,id=mysecret,dst=/tmp/mysecret.txt cat /tmp/mysecret.txt

CMD ["bash", "-c", "env"]