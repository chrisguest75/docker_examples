{
  description = "Installs multitools as a flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  # v4.4 use ffmpeg https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=ffmpeg
  # inputs.nixpkgs-ffmpeg-version.url = "github:nixos/nixpkgs/407f8825b321617a38b86a4d9be11fd76d513da2";
  # 4.4.3 use ffmpeg 
  inputs.nixpkgs-ffmpeg-version.url = "github:nixos/nixpkgs/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
  # 5.1.2 use ffmpeg_5
  #inputs.nixpkgs-ffmpeg-version.url = "github:nixos/nixpkgs/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";

  outputs = { nixpkgs, flake-utils, nixpkgs-ffmpeg-version, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          # Specify the packages to install in the shell
          packages = [
            # Use ffmpeg from ffmpegpkgs v4.x.x
            #(import nixpkgs-ffmpeg-version { inherit system; }).ffmpeg
            # Use ffmpeg from ffmpegpkgs v5.x.x
            (import nixpkgs-ffmpeg-version { inherit system; }).ffmpeg_5
            # Use other packages from nixpkgs
            pkgs.sox
            pkgs.jq
          ];
        };
      });
}