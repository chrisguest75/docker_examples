FROM bash:5.0.7 as bash
RUN uname -a 

#FROM scratch
#COPY --from=bash /bin/sh /bin/sh
#ARG mygithubcreds
#RUN echo "hello"
# ENV mygithubcreds creds
# COPY file1.txt file1.txt

CMD ["/bin/sh", "uname -a"]