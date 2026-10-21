{ pkgs, ... }:

{
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_24;
    # Corepack provides pnpm at the exact version pinned by each project's
    # `packageManager` field. pnpm's own version switching leaves the 12.11+
    # native binary uninstalled on macOS (ENOEXEC).
    corepack.enable = true;
  };
}
