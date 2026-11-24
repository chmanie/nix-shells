{ pkgs, ... }:

let
  # Node 25+ no longer bundles corepack, so devenv's `corepack.enable` (which
  # expects `${package}/bin/corepack`) can't be used. Build the shims from the
  # standalone corepack package instead.
  corepackShims = pkgs.runCommand "corepack-shims" { } ''
    mkdir -p $out/bin
    ${pkgs.corepack}/bin/corepack enable --install-directory $out/bin
  '';
in
{
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_26;
  };

  # Corepack provides pnpm at the exact version pinned by each project's
  # `packageManager` field. pnpm's own version switching leaves the 12.11+
  # native binary uninstalled on macOS (ENOEXEC).
  packages = [
    pkgs.corepack
    corepackShims
  ];
}
