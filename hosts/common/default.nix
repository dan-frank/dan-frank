# This file contains configuration that is shared across all hosts.
{ pkgs, lib, options, ... }:
{
  nix.settings = {
    auto-optimise-store = true;
    keep-derivations = true;
    keep-outputs = true;
    extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  imports = [
    ./fonts.nix
    ./../../settings/fontProfiles.nix
    ./packages.nix
  ];

  programs.zsh = {
    enable = true;
    promptInit = "";
  };
}
