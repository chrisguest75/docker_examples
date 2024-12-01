# syntax=docker/dockerfile:1.4
FROM nixos/nix:latest

WORKDIR /work

COPY --chmod=755 <<EOF /work/multitool.nix
with import <nixpkgs> {};

buildEnv {
  name = "multitool";
  paths = [ 
    bash
    curl
    git
    nano 
  ];
}
EOF

COPY --chmod=755 <<EOF /work/enable-bundle.sh
#!/usr/bin/env bash
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
EOF
RUN "/work/enable-bundle.sh"

ENTRYPOINT [ "/bin/bash" ]