# syntax=docker/dockerfile:1.4
FROM nixos/nix:latest AS BUILDER

WORKDIR /scratch
COPY jq.nix .
RUN nix-build ./jq.nix

RUN find /nix/store -name "ldd" 

# NOTE: Escape the \$ otherwise they are rendered at buildtime
COPY <<EOF /scratch/exportldd.sh
#!/usr/bin/env bash
/nix/store/h0cnbmfcn93xm5dg2x27ixhag1cwndga-glibc-2.34-210-bin/bin/ldd "./result/bin/jq" >  /scratch/libs.txt
cat /scratch/libs.txt | /nix/store/w3p77mkdy3pigg12iyha8y9dqakhjsxn-gawk-5.1.1/bin/awk 'NF == 4 { {print \$3} }' > /scratch/libs_extracted.txt    
cat /scratch/libs_extracted.txt | /nix/store/w3p77mkdy3pigg12iyha8y9dqakhjsxn-gawk-5.1.1/bin/awk -F/ -vOFS=/ '{ print \$1,\$2,\$3,\$4; }' | sort -u > /scratch/libs_paths.txt
tar -cvf /scratch/libraries.tar -T /scratch/libs_paths.txt
mkdir /output
tar xf /scratch/libraries.tar --directory=/output
EOF
RUN chmod +x /scratch/exportldd.sh
RUN /scratch/exportldd.sh
CMD ["./result/bin/jq", "--version"]

FROM gcr.io/distroless/nodejs:16-debug AS PRODUCTION

COPY --from=BUILDER /scratch/result/bin/jq /usr/bin/jq
COPY --from=BUILDER /output /

ENTRYPOINT [ "/usr/bin/jq" ]
CMD ["/usr/bin/jq", "--version"]
