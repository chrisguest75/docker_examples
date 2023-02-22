with import <nixpkgs> {};

buildEnv {
  name = "buildffmpeg";
  paths = [ 
    ffmpeg-full 
    gawk 
  ];
}

