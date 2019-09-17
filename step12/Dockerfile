FROM bash:5.0.7 as bash

COPY demo.sh /bin/demo
RUN chmod +x /bin/demo
COPY background.sh /bin/background
RUN chmod +x /bin/background

CMD ["/bin/demo"]
