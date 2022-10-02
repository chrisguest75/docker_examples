with import <nixpkgs> {};

buildEnv {
  name = "buildjq";
  paths = [ 
    ffmpeg-full 
    gawk 
  ];
}

