FROM bash:5.0.7 as bash

ARG sleeptime
RUN echo ${sleeptime}
RUN sleep ${sleeptime}

CMD ["bash", "-c", "env"]
