with import <nixpkgs> {};

buildEnv {
  name = "buildjq";
  paths = [ 
    jq 
    gawk 
  ];
}