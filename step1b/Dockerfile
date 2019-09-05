# using bash container means lots of layers 
# can I build this and squash it then add files?
FROM bash:5.0.7 as bash1
FROM scratch as final

ENV mysecret notasecret
COPY file1.txt file1.txt
COPY file2.txt file1.txt
COPY file3.txt file1.txt
COPY file2.txt file2.txt
COPY file3.txt file3.txt

COPY --from=bash1 /bin/mv /bin/mv
COPY --from=bash1 /bin/cp /bin/cp
COPY --from=bash1 /bin/rm /bin/rm
COPY --from=bash1 /bin/sh /bin/sh
#RUN /bin/rm /file1.txt
#RUN /bin/mv /file2.txt /file4.txt


