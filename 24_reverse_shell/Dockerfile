FROM ubuntu:16.04 as no_protection

RUN apt-get update && apt-get install netcat -y
ENV REMOTE_HOST=
ENV REMOTE_PORT=

WORKDIR /webserver
COPY stupid_webserver.sh .
COPY server_logic.sh .
CMD ["/webserver/stupid_webserver.sh"]

FROM no_protection as non_root

# Add system user.
RUN groupadd -r webuser && useradd -r -g webuser webuser
USER webuser

CMD ["/webserver/stupid_webserver.sh"]
