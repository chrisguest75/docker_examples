# flake.nix
{
    description = "A flake for working with containerd";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    #       ↑ Swap it for your system if needed
    #       "aarch64-linux" / "x86_64-darwin" / "aarch64-darwin"
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {

      packages = [ 
          pkgs.containerd
          pkgs.runc
       ];

      env = {
        #NIXPKGS_ALLOW_UNFREE=1;
      };

      shellHook = ''
        echo "***************************************************"
        echo "*** Welcome to containerd"
        echo "***************************************************"
        echo ""
        ctr --version
        runc --version
      '';       
    };
  };
}
