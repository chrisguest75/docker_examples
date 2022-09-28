FROM bash:5.0.7 as bash
RUN uname -a 

WORKDIR /scratch
COPY large_file.bin large_file.bin
CMD ["uname", "-a"]