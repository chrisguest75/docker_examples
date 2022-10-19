with import <nixpkgs> {};

buildEnv {
  name = "buildffmpeg";
  paths = [ 
    ffmpeg_5 
    gawk 
  ];
}

