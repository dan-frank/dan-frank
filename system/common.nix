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
    # substituters = [
    #   "https://cache.nixos.org/"
    #   "https://hardselius.cachix.org"
    # ];
    # trusted-public-keys = [
    #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #   "hardselius.cachix.org-1:PoN90aQw2eVMwfAy0MS6V9T2exWlgtHOUBBSnthXAl4="
    # ];
  };

  programs.zsh = {
    enable = true;
    promptInit = "";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ hack-font ];
  };
}
