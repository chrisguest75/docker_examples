FROM bash:5.2.15 as bash1

ARG sleeptime1
RUN echo ${sleeptime1}
RUN sleep ${sleeptime1}

FROM bash:5.2.15 as bash2

ARG sleeptime2
RUN echo ${sleeptime2}
RUN sleep ${sleeptime2}

CMD ["bash", "-c", "env"]

FROM scratch as final
COPY --from=bash1 /usr/local/bin/bash /usr/bin/bash1
COPY --from=bash2 /usr/local/bin/bash /usr/bin/bash2
