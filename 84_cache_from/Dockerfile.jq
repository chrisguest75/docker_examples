# syntax=docker/dockerfile:1.4
ARG baseimage="scratch"
FROM docker.io/nixos/nix@sha256:840bec8bcedf4858ddc525e1a9f41240c2c2a1380fd5315e756119ef66a0aed6 AS BUILDER

ARG SLEEPTIME=0
ARG NIX_FILE=./jq.nix 
ARG PROGRAM_FILE=jq 

WORKDIR /scratch
COPY $NIX_FILE .
RUN sleep ${SLEEPTIME}

RUN nix-build $NIX_FILE
RUN sleep ${SLEEPTIME}

RUN find /nix/store -name "ldd" 
RUN sleep ${SLEEPTIME}

COPY /data /data
RUN sleep ${SLEEPTIME}

# NOTE: Escape the \$ otherwise they are rendered at buildtime
COPY --chmod=755 <<EOF /scratch/exportldd.sh
#!/usr/bin/env bash
/nix/store/h0cnbmfcn93xm5dg2x27ixhag1cwndga-glibc-2.34-210-bin/bin/ldd "./result/bin/$PROGRAM_FILE" >  /scratch/libs.txt
cat /scratch/libs.txt | /nix/store/w3p77mkdy3pigg12iyha8y9dqakhjsxn-gawk-5.1.1/bin/awk 'NF == 4 { {print \$3} }' > /scratch/libs_extracted.txt    
cat /scratch/libs_extracted.txt | /nix/store/w3p77mkdy3pigg12iyha8y9dqakhjsxn-gawk-5.1.1/bin/awk -F/ -vOFS=/ '{ print \$1,\$2,\$3,\$4; }' | sort -u > /scratch/libs_paths.txt
tar -cvf /scratch/libraries.tar -T /scratch/libs_paths.txt
mkdir -p /output/libs /output/bin
tar xf /scratch/libraries.tar --directory=/output/libs
cp "./result/bin/$PROGRAM_FILE" /output/bin
sleep ${SLEEPTIME}
EOF
RUN /scratch/exportldd.sh
CMD ["./output/bin/$PROGRAM_FILE", "--version"]

#FROM $baseimage AS PRODUCTION
FROM bash:5.2.15 AS PRODUCTION

ARG SLEEPTIME=0
COPY --from=BUILDER /output/bin/$PROGRAM_FILE /usr/bin/$PROGRAM_FILE
RUN sleep ${SLEEPTIME}
COPY --from=BUILDER /output/libs /
RUN sleep ${SLEEPTIME}
COPY --from=BUILDER /data /data
RUN sleep ${SLEEPTIME}

ENTRYPOINT [ "/usr/bin/jq" ]
CMD ["/usr/bin/jq", "--version"]
