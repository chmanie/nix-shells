{
  description = "Central Node + pnpm environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodejs_22
            pkgs.pnpm
          ];

          shellHook = "";

          # shellHook = ''
          #   if [ -z "$_NIX_SHELL_LOADED" ]; then
          #     export _NIX_SHELL_LOADED=1
          #     echo "⚡️ Central Node environment loaded!" >&2
          #     echo "Node: $(node --version)" >&2
          #     echo "pnpm: $(pnpm --version)" >&2
          #   fi
          # '';
        };
      }
    );
}
