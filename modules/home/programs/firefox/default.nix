{ pkgs, lib, ... }:
let
  merge = lib.foldr (a: b: a // b) { };
in
{
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.isLinux then pkgs.firefox else pkgs.firefox-bin;
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
          sponsorblock
          ublock-origin
          vimium
        ];
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
