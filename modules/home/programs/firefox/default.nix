{ config, pkgs, lib, ... }:
let
  merge = lib.foldr (a: b: a // b) { };
  pkgsFirefox = if pkgs.stdenv.isLinux then pkgs.firefox else pkgs.firefox-bin;
in {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.shellAliases = {
    firefox = "Open ${pkgsFirefox}/Applications/Firefox.app";
  };

  programs.firefox = {
    enable = true;
    package = pkgsFirefox;
    profiles = {
      default = {
        name = "Default";
        settings = merge [
          (import ./config/annoyances.nix)
          (import ./config/browser-features.nix)
          (import ./config/privacy.nix)
          (import ./config/tracking.nix)
          (import ./config/security.nix)
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          facebook-container
          onepassword-password-manager
          return-youtube-dislikes
          sourcegraph
          sponsorblock
          ublock-origin
          vimium
        ];
        userChrome = builtins.readFile ./config/userChrome.css;
      };
      # This does not have as strict privacy settings as the default profile.
      # It uses the default firefox settings. Useful when something is not
      # working using the default profile
      shit = {
        name = "crap";
        id = 1;
      };
    };
  };
}
