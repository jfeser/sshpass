{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, flake-utils, nixpkgs }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        defaultPackage = pkgs.stdenv.mkDerivation {
          pname = "sshpass";
          version = "1.10";
          src = ./.;
          nativeBuildInputs = [ pkgs.autoreconfHook ];
        };
      in {
        defaultPackage = defaultPackage;
        devShell = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.clang-tools ];
          inputsFrom = [ defaultPackage ];
        };
      });
}
